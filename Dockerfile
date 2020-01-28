FROM plus3it/tardigrade-ci:0.0.4

WORKDIR /ci-harness
ENTRYPOINT ["make"]

