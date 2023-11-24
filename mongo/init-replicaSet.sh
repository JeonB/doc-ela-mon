set -e

mongosh --quiet --norc "mongodb://${MONGO_HOSTNAME}:${MONGO_PORT}" --eval <<EOF
    try {
        rs.initiate({
            _id: '${MONGO_REPLSET_NAME}',
            members: [
                { _id: 0, host: '${MONGO_HOSTNAME}' , priority: 2}
            ]
        }, { force: true });
    } catch (e) {
    } finally {
        rs.status().ok;
    }
EOF
