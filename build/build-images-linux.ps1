try {
    $info = docker version -f json | ConvertFrom-Json
    $env:DOCKER_BUILD_OS = $info.Server.Os.ToLower()
    $env:DOCKER_BUILD_CPU = $info.Server.Arch.ToLower()

    docker compose `
        -f compose-images-linux.yml `
        -f compose-images-linux-tags.yml `
        build --pull

    docker compose `
        -f compose-images-linux.yml `
        -f compose-images-linux-tags.yml `
        push
    
    docker compose `
        -f compose-images-linux.yml `
        build
}

finally {
    popd
}