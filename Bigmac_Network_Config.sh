# Node 1
/etc/systemd/network/20-wired.network
`
[Match]
MACAddress=00:15:b2:a1:f6:94

[Network]
Address=140.114.91.93/24
Address=10.20.85.1/24
Gateway=140.114.91.254
DNS=140.114.63.1
DNS=140.114.64.1
DNS=8.8.8.8
IPForward=1
IPMasquerade=1
`

/etc/systemd/network/ibp5s0.network
`
[Match]
Name=ibp5s0

[Network]
Address=10.20.95.1/24
`

# Node 2
/etc/systemd/network/20-wired.network
`
[Match]
MACAddress=00:15:b2:a1:f3:ac

[Network]
Address=10.20.85.2/24
Gateway=10.20.85.1
#DNS=8.8.8.8
`

/etc/systemd/network/ibp5s0.network
`
[Match]
Name=ibp5s0

[Network]
Address=10.20.95.2/24
`