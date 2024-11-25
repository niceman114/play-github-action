version=$(echo "{$COMMIT_MESSAGE}" | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+')
if [ -z "${version}" ]; then
    echo "Version not found in commit message:"
    echo ">> ${COMMIT_MESSAGE}"
    echo "Sending error to Slack..."
    curl -s -X POST -H 'Content-type: application/json' --data '{"text":"Error: Version not found in commit message."}' "${SLACK_WEBHOOK_URL}"
    exit $?
fi
if [ -f "${GITHUB_ENV}" ]; then
    echo "VERSION=${version}" >> ${GITHUB_ENV}
    echo "Save to ${GITHUB_ENV}"
fi
echo Extracted version : ${version}
