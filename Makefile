build:
	docker buildx build -t fsmgmt .

run:
	docker kill fsmgmt
	docker run --name fsmgmt --rm -p 8000:80 -v /tmp:/files -d fsmgmt

test:
	docker exec -it fsmgmt pytest --exitfirst test_main.py