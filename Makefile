all:
	make build_backend

build_init:
	find server/plugin/plg_* -type f -name "install.sh" -exec {} \;

build_frontend:
	NODE_ENV=production npm run build

build_backend:
	PKG_CONFIG_PATH=/usr/lib/pkgconfig/ CGO_CFLAGS_ALLOW='-fopenmp' go build -mod=vendor --tags "fts5" -ldflags "-X github.com/claps-company/filestash/server/common.BUILD_DATE=`date -u +%Y%m%d` -X github.com/claps-company/filestash/server/common.BUILD_REF=`git rev-parse HEAD`" -o dist/filestash server/main.go
