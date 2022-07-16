local service_locator = {}

service_locator.liste = {}

function service_locator.addService(pService, pModule)
    service_locator.liste[pService] = pModule
end

function service_locator.getService(pService)
    return service_locator.liste[pService]
end

return service_locator