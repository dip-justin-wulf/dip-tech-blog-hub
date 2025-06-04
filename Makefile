all: help

help:       ##ヘルプ表示
	@grep -F '##' $(MAKEFILE_LIST) | grep -v grep | sed -e 's/##//g'

up:      ##dockerコンテナ起動
	@docker compose up -d

down:       ##dockerコンテナ停止
	@docker compose down

dev:        ##devサーバー起動
	@docker compose exec app npm run dev

lint:       ##linter実行
	cd src && npm run lint

format:       ##Formatter実行
	cd src && npm run format

type-check:       ##型チェック実行
	cd src && npm run check-types

init:       ##環境再構築(.env.localの初期化を含む)
	@if [[ -z "`docker network ls | grep spotbaitoru-shared-network`" ]]; then docker network create spotbaitoru-shared-network; fi
	cp src/.env.sample src/.env.local
	@make destroy
	@make install
	@make git-config
	cd src && npm run prepare
	cd ..

install:    ##環境構築
	@docker compose up -d
	@docker compose exec app npm install

destroy:    ##環境破棄
	@docker compose down --rmi all --volumes --remove-orphans
