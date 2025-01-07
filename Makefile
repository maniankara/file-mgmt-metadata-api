build:
	docker buildx build -t fsmgmt .

test:
	docker run --name fsmgmt --rm -p 8000:80 -v /tmp:/files fsmgmt pytest --exitfirst test_main.py

run:
	docker run --name fsmgmt --rm -p 8000:80 -v /tmp:/files -d fsmgmt
