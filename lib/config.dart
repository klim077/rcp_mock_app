const protocol = "http://";
// const backendIP = "192.168.1.119";    // NTU Network
const backendIP = "192.168.5.69";
// const backendIP = "192.168.1.102";
const backendURL = "$protocol$backendIP";
// const mongoApiVersion = "v0.1/ui";
const mongoApiVersion = "v0.1";
const mongoApiIp = "$backendURL:22090/$mongoApiVersion/";
