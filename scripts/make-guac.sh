#!/bin/bash
#
# Description:
#    This script is intended to aid an administrator in quickly
#    setting up a baseline configuration of the Guacamole
#    management-protocol HTTP-tunneling service. When the script
#    exits successfully, Guacamole will be listening at
#    "localhost:8080"
#
#################################################################
__SCRIPTNAME="make-guac.sh"

set -e
set -o pipefail

log()
{
    # Logs messages to logger and stdout
    # Reads log messages from $1 or stdin
    if [[ "${1-UNDEF}" != "UNDEF" ]]
    then
        # Log message is $1
        logger -i -t "${__SCRIPTNAME}" -s -- "$1" 2> /dev/console
        echo "${__SCRIPTNAME}: $1"
    else
        # Log message is stdin
        while IFS= read -r IN
        do
            log "$IN"
        done
    fi
}

die()
{
    [ -n "$1" ] && log "$1"
    log "Guacamole install failed"'!'
    exit 1
}  # ----------  end of function die  ----------


retry()
{
    # Make an arbitrary number of attempts to execute an arbitrary command,
    # passing it arbitrary parameters. Convenient for working around
    # intermittent errors (which occur often with poor repo mirrors).
    #
    # Returns the exit code of the command.
    local n=0
    local try=$1
    local cmd="${*: 2}"
    local result=1
    [[ $# -le 1 ]] && {
        echo "Usage $0 <number_of_retry_attempts> <Command>"
        exit $result
    }

    echo "Will try $try time(s) :: $cmd"

    if [[ "${SHELLOPTS}" == *":errexit:"* ]]
    then
        set +e
        local ERREXIT=1
    fi

    until [[ $n -ge $try ]]
    do
        sleep $n
        $cmd
        result=$?
        # shellcheck disable=2015
        test $result -eq 0 && break || {
            ((n++))
            echo "Attempt $n, command failed :: $cmd"
        }
    done

    if [[ "${ERREXIT}" == "1" ]]
    then
        set -e
    fi

    return $result
}  # ----------  end of function retry  ----------


usage()
{
    cat << EOT
  Usage:  ${__SCRIPTNAME} [options]

  Note:
  After successful execution, Guacamole will be installed and running in two
  Docker containers. One container for the backend "guacd" service, and a
  second container for the frontend "guacamole" tomcat java servlet. The
  webapp will be running at "localhost:8080".

  Options:
  -h  Display this message.
  -H  Hostname of the LDAP server to authenticate users against
      (e.g. ldap.example.com). Using the domain DNS name is acceptable as long
      as it resolves to an LDAP server (e.g. example.com). If specified, LDAP
      authentication will be installed and configured. Requires -D.
  -D  Distinguished Name (DN) of the directory (e.g. DC=example,DC=com).
      Required by -H.
  -U  The base of the DN for all Guacamole users. This is prepended to the
      directory DN (-D) to create the full DN to the user container. This will
      be appended to the username when a user logs in. Default is "CN=Users".
  -R  The base of the DN for all Guacamole roles. This is used by the LDAP
      plugin to search for groups the user is a member of. Using this option
      will enable Roles Based Access Control (RBAC) support. This is prepended
      to the directory DN (-D) to create the full DN to the RBAC container.
  -A  The attribute which contains the username and which is part of the DN
      for all Guacamole users. Usually, this will be "uid" or "cn". This is
      used together with the user base DN (-U) to derive the full DN of each
      user logging in. Default is "cn".
  -C  The base of the DN for all Guacamole configurations. Each configuration
      is analogous to a connection. This is prepended to the directory DN (-D)
      to create the full DN to the configuration container. Default is
      "CN=GuacConfigGroups". NOTE: This default value does not exist by
      default in the LDAP directory and will need to be created, or a
      different value will need to be provided.
  -P  Port on which to connect to the LDAP server. Default is "389".
  -L  URL for first link to be included in Guac login page. If -T is specified,
      then this parameter is required for successful modification.
  -T  Text to be displayed for the URL provided with -L.  If -L is specified,
      then this parameter is required for successful modification.
  -l  URL for second link to be included in Guac login page. If -t is specified,
      then this parameter is required for successful modification.
  -t  Text to be displayed for the URL provided with -l.  If -l is specified,
      then this parameter is required for successful modification.
  -B  Text for branding of the homepage. Default is "Apache Guacamole".
  -V  Docker image to use for Guacamole. Default is "guacamole/guacamole"
  -v  Docker image to use for guacd. Default is "guacamole/guacd"
  -S  AWS Systems Manager path to Docker username
  -s  AWS Systems Manager path to Docker password
  -E  MySQL remote database server hostname or IP address
  -e  MySQL remote database server port
  -F  MySQL remote database SSL mode
  -f  MySQL remote database name
  -G  MySQL remote database user name
  -g  MySQL remote database user password
  -K  Decision on whether to automatically create a new database user when
      using one of the other authentication extension options.
  -k  Comma-delimited list of extension namespaces designating the order each is loaded
  -I  SAML entity ID
  -i  SAML Identity Provider metadata URL
  -J  SAML callback URL
  -j  SAML groups attribute
  -w  Name of AWS Log Group where Docker logs will be streamed

EOT
}  # ----------  end of function usage  ----------


# Guac manifest file for using extensions
write_manifest()
{
    local guac_tmp
    local guac_manifest
    guac_tmp="$1"
    guac_manifest="${guac_tmp}/guac-manifest.json"

    log "Writing Guac manifest file"
    (
        printf "{\n"
        printf "\"guacamoleVersion\" : \"*\",\n"
        printf "\"name\" : \"Custom Extension\",\n"
        printf "\"namespace\" : \"custom-extension\",\n"
        printf "\"html\" : [ \"custom-urls.html\" ],\n"
        printf "\"translations\" : [ \"translations/en.json\" ]\n"
        printf "}\n"
    ) > "${guac_manifest}"
    if ! { [[ -n "${URL_1}" ]] || [[ -n "${URL_2}" ]]; }
    then
        sed -i '/html/d' "${guac_manifest}"
    fi
    log "Successfully wrote manifest for custom Guacamole branding extension"
}  # ----------  end of function write_manifest  ----------


# Guac links extension file
write_links()
{
    local guac_tmp
    local guac_links
    guac_tmp="$1"
    guac_links="${guac_tmp}/custom-urls.html"

    log "Writing Guac html extension file to add in custom URLs"
    (
        printf "<meta name=\"after\" content=\".login-ui .login-dialog\">\n"
        printf "\n"
        printf "<div class=\"welcome\">\n"
        printf "<p>\n"
        printf "<a target=\"_blank\" href=\"%s\">%s</a>\n" "$URL_1" "$URLTEXT_1"
        printf "</p>\n"
        printf "<p>\n"
        printf "<a target=\"_blank\" href=\"%s\">%s</a>\n" "$URL_2" "$URLTEXT_2"
        printf "</p>\n"
        printf "</div>\n"
    ) > "${guac_links}"
    log "Successfully wrote html for custom Guacamole branding extension"
}  # ----------  end of function write_links  ----------


# Guac branding extension file
write_brand()
{
    local guac_tmp
    local guac_translations
    local guac_translations_en
    guac_tmp="$1"
    guac_translations="${guac_tmp}/translations"
    guac_translations_en="${guac_translations}/en.json"

    log "Writing Guac extension translation file with custom branding text"
    mkdir -p "${guac_translations}"
    (
        printf "{\n"
        printf "\"APP\" : { \"NAME\" : \"%s\" }\n" "$BRANDTEXT"
        printf "}\n"
    ) > "${guac_translations_en}"
    log "Successfully added branding text to Guacamole login page"
}  # ----------  end of function write_brand  ----------


# Define default values
AWSLOGS_GROUP=
LDAP_HOSTNAME=
LDAP_DOMAIN_DN=
LDAP_USER_BASE="CN=Users"
LDAP_USER_ATTRIBUTE="cn"
LDAP_CONFIG_BASE="CN=GuacConfigGroups"
LDAP_GROUP_BASE="CN=Users"
LDAP_PORT="389"
MYSQL_HOSTNAME=
MYSQL_PORT="3306"
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=
MYSQL_SSL_MODE="disabled"
MYSQL_AUTO_CREATE_ACCOUNTS=true
SAML_CALLBACK_URL=
SAML_ENTITY_ID=
SAML_IDP_METADATA_URL=
SAML_DEBUG=True
URL_1=
URLTEXT_1=
URL_2=
URLTEXT_2=
BRANDTEXT="Apache Guacamole"
DOCKER_GUACAMOLE_IMAGE=guacamole/guacamole
DOCKER_GUACD_IMAGE=guacamole/guacd
SSM_DOCKER_USERNAME=
SSM_DOCKER_PASSWORD=

# Parse command-line parameters
while getopts :hH:D:U:R:A:C:P:L:T:l:t:B:V:v:S:s:E:e:F:f:G:g:I:i:J:j:K:k:w: opt
do
    case "${opt}" in
        h)
            usage
            exit 0
            ;;
        H)
            LDAP_HOSTNAME="${OPTARG}"
            ;;
        D)
            LDAP_DOMAIN_DN="${OPTARG}"
            ;;
        U)
            LDAP_USER_BASE="${OPTARG}"
            ;;
        R)
            LDAP_GROUP_BASE="${OPTARG}"
            ;;
        A)
            LDAP_USER_ATTRIBUTE="${OPTARG}"
            ;;
        C)
            LDAP_CONFIG_BASE="${OPTARG}"
            ;;
        P)
            LDAP_PORT="${OPTARG}"
            ;;
        E)
            MYSQL_HOSTNAME="${OPTARG}"
            ;;
        e)
            MYSQL_PORT="${OPTARG}"
            ;;
        F)
            MYSQL_SSL_MODE="${OPTARG}"
            ;;
        f)
            MYSQL_DATABASE="${OPTARG}"
            ;;
        G)
            MYSQL_USER="${OPTARG}"
            ;;
        g)
            MYSQL_PASSWORD="${OPTARG}"
            ;;
        K)
            MYSQL_AUTO_CREATE_ACCOUNTS="${OPTARG}"
            ;;
        k)
            EXTENSION_PRIORITY="${OPTARG}"
            ;;
        I)
            SAML_ENTITY_ID="${OPTARG}"
            ;;
        i)
            SAML_IDP_METADATA_URL="${OPTARG}"
            ;;
        J)
            SAML_CALLBACK_URL="${OPTARG}"
            ;;
        j)
            SAML_GROUP_ATTRIBUTE="${OPTARG}"
            ;;
        L)
            URL_1="${OPTARG}"
            ;;
        T)
            URLTEXT_1="${OPTARG}"
            ;;
        l)
            URL_2="${OPTARG}"
            ;;
        t)
            URLTEXT_2="${OPTARG}"
            ;;
        B)
            BRANDTEXT="${OPTARG}"
            ;;
        V)
            DOCKER_GUACAMOLE_IMAGE="${OPTARG}"
            ;;
        v)
            DOCKER_GUACD_IMAGE="${OPTARG}"
            ;;
        S)
            SSM_DOCKER_USERNAME="${OPTARG}"
            ;;
        s)
            SSM_DOCKER_PASSWORD="${OPTARG}"
            ;;
        w)
            AWSLOGS_GROUP="${OPTARG}"
            ;;
        \?)
            usage
            echo "ERROR: unknown parameter \"$OPTARG\""
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))


# Validate parameters
if [[ -z "${LDAP_HOSTNAME}" ]] && [[ -z ${SAML_IDP_METADATA_URL} ]] && [[ -z ${MYSQL_HOSTNAME} ]]
then
    die "No authentication option provided.  Please configure at least one option."
elif [[ -n "${LDAP_HOSTNAME}" ]] && [[ -n ${SAML_IDP_METADATA_URL} ]]
then
    die "Both LDAP and SAML authentication specified. Please configure only one or the other."
fi

if [ -n "${LDAP_HOSTNAME}" ]
then
    if [ -z "${LDAP_DOMAIN_DN}" ]
    then
        die "LDAP Hostname was provided (-H), but the LDAP Domain DN was not (-D)"
    fi
elif [ -n "${LDAP_DOMAIN_DN}" ]
then
    die "LDAP Domain DN was provided (-D), but the LDAP Hostname was not (-H)"
fi


# Validate parameter pairs of URL and URLTEXT are appropriately populated
if [ -n "${URL_1}" ]
then
    if [ -z "${URLTEXT_1}" ]
    then
        die "URL1 was provided (-L), but the partner URLTEXT was not (-T), login page unmodified; exiting"
    fi
elif [ -n "${URLTEXT_1}" ]
then
    die "URLTEXT1 was provided (-T), but the URL was not (-L), login page unmodified; exiting"
fi

if [ -n "${URL_2}" ]
then
    if [ -z "${URLTEXT_2}" ]
    then
        die "URL2 was provided (-l), but the partner URLTEXT was not (-t), login page unmodified; exiting"
    fi
elif [ -n "${URLTEXT_2}" ]
then
    die "URLTEXT2 was provided (-t), but the URL was not (-l), login page unmodified; exiting"
fi


# Set internal variables
CATALINA_CONF=/usr/local/tomcat/conf/server.xml
DOCKER_GUACD=guacd
DOCKER_GUACAMOLE=guacamole
GUAC_EXT=/tmp/extensions
GUAC_HOME=/root/guac-home
GUAC_DRIVE=/var/tmp/guacamole
EC2_METADATA_TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
EC2_INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $EC2_METADATA_TOKEN" -v http://169.254.169.254/latest/meta-data/instance-id)

# Setup build directories
log "Initializing ${__SCRIPTNAME} build directories"
rm -rf "${GUAC_EXT}" "${GUAC_HOME}" "${GUAC_DRIVE}" | log
mkdir -p "${GUAC_EXT}" "${GUAC_HOME}/extensions" "${GUAC_DRIVE}" | log

# Install dependencies
log "Installing docker"
retry 2 yum -y install docker | log
log "Installing xmlstarlet"
retry 2 yum -y install xmlstarlet | log

# start docker
log "Starting docker"
service docker start | log

# enable docker service
log "Enabling docker services"
chkconfig docker on | log

# configure docker authentication if AWS SSM parameters provided
if [[ -n "${SSM_DOCKER_USERNAME:-}" ]] && [[ -n "${SSM_DOCKER_PASSWORD:-}" ]]
then
  DOCKER_USERNAME=$(aws ssm get-parameters --name "$SSM_DOCKER_USERNAME" --with-decryption --query 'Parameters[0].Value' --output text)
  DOCKER_PASSWORD=$(aws ssm get-parameters --name "$SSM_DOCKER_PASSWORD" --with-decryption --query 'Parameters[0].Value' --output text)
  if [[ "$DOCKER_USERNAME" == "None" ]] || [[ "$DOCKER_PASSWORD" == "None" ]]
  then
    log "Docker username or password is invalid, skipping Docker authentication"
  else
    log "Valid Docker username and password parameters provided, configuring Docker authentication"
    echo "${DOCKER_PASSWORD}" | docker login --username "${DOCKER_USERNAME}" --password-stdin
  fi
fi

# fetch the guacd image
log "Fetching the guacd image, ${DOCKER_GUACD_IMAGE}"
retry 2 docker pull "${DOCKER_GUACD_IMAGE}" | log

# fetch the guacamole image
log "Fetching the guacamole image, ${DOCKER_GUACAMOLE_IMAGE}"
retry 2 docker pull "${DOCKER_GUACAMOLE_IMAGE}" | log

# Create custom guacamole branding extension
log "Setting up the custom branding extension"
write_manifest "${GUAC_EXT}"
write_brand "${GUAC_EXT}"

if [[ -n "${URL_1}" ]] || [[ -n "${URL_2}" ]]
then
    # Add custom URLs to Guacamole login page using Guac extensions.
    write_links "${GUAC_EXT}"
else
    log "URL parameters were blank, not adding links"
fi

log "Creating jar for custom branding extension"
pushd "$(pwd)" > /dev/null
cd "${GUAC_EXT}"
zip -v -r "${GUAC_HOME}/extensions/custom.jar" . | log
popd > /dev/null


# Cleanup any running/pre-existing guac docker containers
if [[ $(docker ps --filter name="${DOCKER_GUACD}" | grep -q "${DOCKER_GUACD}")$? -eq 0 ]]
then
    log "Stopping ${DOCKER_GUACD} container"
    docker stop "${DOCKER_GUACD}" | log
fi

if [[ $(docker ps --all --filter name="${DOCKER_GUACD}" | grep -q "${DOCKER_GUACD}")$? -eq 0 ]]
then
    log "Removing ${DOCKER_GUACD} container"
    docker rm "${DOCKER_GUACD}" | log
fi

if [[ $(docker ps --filter name="${DOCKER_GUACAMOLE}" | grep -q "${DOCKER_GUACAMOLE}")$? -eq 0 ]]
then
    log "Stopping ${DOCKER_GUACAMOLE} container"
    docker stop "${DOCKER_GUACAMOLE}" | log
fi

if [[ $(docker ps --all --filter name="${DOCKER_GUACAMOLE}" | grep -q "${DOCKER_GUACAMOLE}")$? -eq 0 ]]
then
    log "Removing ${DOCKER_GUACAMOLE} container"
    docker rm "${DOCKER_GUACAMOLE}" | log
fi

# Initialize arrays for Docker run parameters
params_begin=(
    --restart unless-stopped
    --link guacd:guacd
    -v "${GUAC_HOME}":/guac-home
    -e GUACAMOLE_HOME=/guac-home
)

params_log_driver_guacd=()
params_log_driver_guacamole=()

params_saml=()

params_mysql=()

params_end=(
    -d -p 8080:8080 "${DOCKER_GUACAMOLE_IMAGE}"
)

# Set extension priority if present
[[ -z $EXTENSION_PRIORITY ]] || params_begin+=(-e EXTENSION_PRIORITY="${EXTENSION_PRIORITY}")

# Build SAML parameters if present
[[ -z $SAML_IDP_METADATA_URL ]] || params_saml+=(-e SAML_IDP_METADATA_URL="${SAML_IDP_METADATA_URL}")
[[ -z $SAML_ENTITY_ID ]] || params_saml+=(-e SAML_ENTITY_ID="${SAML_ENTITY_ID}")
[[ -z $SAML_CALLBACK_URL ]] || params_saml+=(-e SAML_CALLBACK_URL="${SAML_CALLBACK_URL}")
[[ -z $SAML_GROUP_ATTRIBUTE ]] || params_saml+=(-e SAML_GROUP_ATTRIBUTE="${SAML_GROUP_ATTRIBUTE}")
[[ -z $SAML_DEBUG ]] || params_saml+=(-e SAML_DEBUG="${SAML_DEBUG}")

# Build MYSQL parameters if present
[[ -z $MYSQL_HOSTNAME ]] || params_mysql+=(-e MYSQL_HOSTNAME="${MYSQL_HOSTNAME}")
[[ -z $MYSQL_PORT ]] || params_mysql+=(-e MYSQL_PORT="${MYSQL_PORT}")
[[ -z $MYSQL_DATABASE ]] || params_mysql+=(-e MYSQL_DATABASE="${MYSQL_DATABASE}")
[[ -z $MYSQL_USER ]] || params_mysql+=(-e MYSQL_USER="${MYSQL_USER}")
[[ -z $MYSQL_PASSWORD ]] || params_mysql+=(-e MYSQL_PASSWORD="${MYSQL_PASSWORD}")
[[ -z $MYSQL_SSL_MODE ]] || params_mysql+=(-e MYSQL_SSL_MODE="${MYSQL_SSL_MODE}")
[[ -z $MYSQL_AUTO_CREATE_ACCOUNTS ]] || params_mysql+=(-e MYSQL_AUTO_CREATE_ACCOUNTS="${MYSQL_AUTO_CREATE_ACCOUNTS}")

# Build log driver parameters if present
if [[ -n $AWSLOGS_GROUP ]]
then
    params_log_driver=()
    params_log_driver+=(--log-driver=awslogs)
    params_log_driver+=(--log-opt awslogs-group="${AWSLOGS_GROUP}")
    params_log_driver+=(--log-opt awslogs-create-group=true)

    params_log_driver_guacd=("${params_log_driver[@]}")
    params_log_driver_guacd+=(--log-opt awslogs-stream="${EC2_INSTANCE_ID}//docker/guacd")

    params_log_driver_guacamole=("${params_log_driver[@]}")
    params_log_driver_guacamole+=(--log-opt awslogs-stream="${EC2_INSTANCE_ID}//docker/guacamole")
fi

# Starting guacd container
log "Starting guacd container, ${DOCKER_GUACD_IMAGE}"
docker run --name guacd \
    --restart unless-stopped \
    "${params_log_driver_guacd[@]}" \
    -v "${GUAC_DRIVE}":"${GUAC_DRIVE}" \
    -d "${DOCKER_GUACD_IMAGE}" | log

# Starting guacamole container

log "Starting guacamole container, ${DOCKER_GUACAMOLE_IMAGE}"

if [[ -n $LDAP_HOSTNAME ]]
then
    log "Using LDAP authentication, ${LDAP_HOSTNAME}"
    docker run --name guacamole \
        "${params_begin[@]}" \
        "${params_log_driver_guacamole[@]}" \
        -e LDAP_HOSTNAME="${LDAP_HOSTNAME}" \
        -e LDAP_PORT="${LDAP_PORT}" \
        -e LDAP_USER_BASE_DN="${LDAP_USER_BASE},${LDAP_DOMAIN_DN}" \
        -e LDAP_USERNAME_ATTRIBUTE="${LDAP_USER_ATTRIBUTE}" \
        -e LDAP_CONFIG_BASE_DN="${LDAP_CONFIG_BASE},${LDAP_DOMAIN_DN}" \
        -e LDAP_GROUP_BASE_DN="${LDAP_GROUP_BASE},${LDAP_DOMAIN_DN}" \
        "${params_mysql[@]}" \
        "${params_end[@]}" | log
elif [[ -n $SAML_IDP_METADATA_URL ]]
then
    log "Using SAML authentication, ${SAML_IDP_METADATA_URL}"

    # Add CATALINA_CONF with x-forwarded-proto configuration docker container
    log "Linking updated server.xml file with x-forward-proto configuration"
    params_begin+=(-v "/etc/cfn/files/tomcat/conf/server.xml":"${CATALINA_CONF}")

    # Configure guacamole.properties to use environment variables
    log "Creating guacamole.properties file and enable environment properties usage"
    touch "${GUAC_HOME}/guacamole.properties"
    echo "enable-environment-properties: true" > "${GUAC_HOME}/guacamole.properties"

    # Initial docker run to grab SAML extension jar
    log "Starting intial Guacamole docker to copy SAML extension jar"
    docker run --rm -dit --name guacamole \
        --entrypoint bash \
        "${DOCKER_GUACAMOLE_IMAGE}" | log

    # Copy SAML jar to ${GUAC_HOME}/extensions/ folder
    log "Copying SAML jar file to extensions folder"
    SAML_JAR_FILENAME=$(docker exec -u root guacamole find /opt/guacamole/saml/ -name "*.jar" | awk -F/ '{print $NF}')
    docker cp guacamole:/opt/guacamole/saml/"${SAML_JAR_FILENAME}" "${GUAC_HOME}"/extensions/"${SAML_JAR_FILENAME}"

    # Remove initial docker run
    docker rm -f guacamole

    log "Launching Guacamole container with all configurations"
    docker run --name guacamole \
        "${params_begin[@]}" \
        "${params_log_driver_guacamole[@]}" \
        "${params_saml[@]}" \
        "${params_mysql[@]}" \
        "${params_end[@]}" | log
fi
