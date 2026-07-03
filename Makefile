.PHONY: fmt validate
fmt:
	terraform fmt -recursive
validate:
	@for e in dev staging prod; do \
	  echo "==> $$e"; \
	  (cd environments/$$e && terraform init -backend=false && terraform validate); \
	done
