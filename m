Content-Type: multipart/mixed; boundary="===============8050653932754447808=="
MIME-Version: 1.0
From: Mark van der Putten <mark.van.der.putten@intemo.com>
Subject: ofono 1.22
Date: Tue, 17 Apr 2018 17:58:59 +0200
Message-ID: <a27b6b42-c386-bb42-0d5b-0b53359340ee@intemo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8050653932754447808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Used ofono 1.16 for a long time. While upgrading to 1.22 there is a
signal 11. (Also on 1.23)

Target: armv7ahf-vfp-neon-oe-linux-gnueabi

Execute: ofonod -d -n

.
.
.
ofono-1.22/src/modem.c:ofono_modem_driver_register() driver: 0x130088,
name: infineon
ofono-1.22/src/modem.c:ofono_modem_driver_register() driver: 0x130040,
name: ril
ofono-1.22/plugins/udevng.c:udev_start()
ofono-1.22/plugins/udevng.c:enumerate_devices()
ofono-1.22/plugins/udevng.c:add_serial_device() Device is missing
required OFONO_DRIVER property
ofono-1.22/plugins/udevng.c:add_serial_device() Device is missing
required OFONO_DRIVER property
ofono-1.22/plugins/udevng.c:add_serial_device() Device is missing
required OFONO_DRIVER property
ofono-1.22/plugins/udevng.c:add_serial_device() Device is missing
required OFONO_DRIVER property
ofono-1.22/plugins/udevng.c:add_serial_device() Device is missing
required OFONO_DRIVER property
ofono-1.22/plugins/udevng.c:add_serial_device() Device is missing
required OFONO_DRIVER property
ofono-1.22/plugins/udevng.c:add_serial_device() Device is missing
required OFONO_DRIVER property
ofono-1.22/plugins/udevng.c:add_serial_device() Device is missing
required OFONO_DRIVER property
ofono-1.22/plugins/udevng.c:add_serial_device() Device is missing
required OFONO_DRIVER property
ofono-1.22/plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofono-1.22/plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofono-1.22/plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofono-1.22/plugins/udevng.c:check_usb_device() cdc_acm [(null):(null)]
ofonod[27193]: Aborting (signal 11) [ofonod]

Can someone shine a light on this?


--===============8050653932754447808==
Content-Type: application/pgp-keys
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pEpkey.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUVOQkZxNlVvUUJDQURuUHFB
S1hIT2JRbmh1NmJrZXdGQm1mYlM0TlJWZ3VwQ1pLZ3RGY1paOXBUQlZoNzRLCnpseFJhdnFQTVhW
ZVJPbk1vWW9ZWmtEV01UMldMKzgwZW43czVmSGNUMzlXclh3ZHhnWWJQT0I1ampKZy91RE8KM25E
ZmJvTjhVWkU5bDNjVnRuSnZJdElhSWlVZTFnczBCOHNxY216Z3FUU3hURjV0L240UG1Ucysvd3g1
SkFuYQpuRGQ1cTZpRzFFWlVCdzNyOVo5U0d6dmhjMUdYcndubnlsVTdmMnBNMzFrNmEwa09WaXEr
aHh5SG1lVzBoZmFsCnlMZ2VULy91SFE0THdIZG9Nalo3eTc0MkdzYmxWU2ZoQXZUK2U3b1lPcTdB
cUovQkxEQWVLN21jMXRObVEzRG4KdXg4RUwvK1Y5aWJGWkMyWld4cnZTbXpsekdmMjVxTkwyTHhW
QUJFQkFBRzBORTFoY21zZ2RtRnVJR1JsY2lCUQpkWFIwWlc0Z1BHMWhjbXN1ZG1GdUxtUmxjaTV3
ZFhSMFpXNUFhVzUwWlcxdkxtTnZiVDZKQVZRRUV3RUlBRDRXCklRUTZydG9IaXRJTlJiMU9yMURD
MFFZTHJzaHh2d1VDV3JwU2hRSWJBd1VKQWVFemdBVUxDUWdIQWdZVkNBa0sKQ3dJRUZnSURBUUll
QVFJWGdBQUtDUkRDMFFZTHJzaHh2M1ZjQ0FEZnpNWHIySVdJYkhieHRGRmFtbXhER2xSegpuVS9I
b2lRdEFTeXVzc1AyV01Ba3F2QlFDWngwejh1TzIxaHF1clM4eG1uNkgrZDlEbEtjdjgyQ3oxSnVD
cWdVClY4TXJiVFVoZkpUU0VSajVjc1hMdXlMYVNvT0ZQUTJ1WHV5dFB3TUhrU3h0T0liOG5JYlFC
OE1ackVyM2F5ZlYKT1M0SzUvTnhuVVBsR0dEMTN5Mm5aNStpRTVBMW1EWkJsVnVRclJ0cTM1THlv
TDk5RDNVZFdCZkMvRnlxeEw3YwpKSkFmUno5K0ZWQWpEMm1Hd3hsendGNUNTaFhsU3BHVHMzUFVv
QnBWcEl6YnNibzJ0aUZ5UDk2MUZFcHE3S1pHCmF0UUJvOXhwWmh0YWdZbS9CY0VWY2lOakRNNGpL
RURCbFFWaUcwdzRCVjNmMkxoMVVwK2xPTE54ZkdUTHVRRU4KQkZxNlVvUUJDQURjUkMwVldXcm9u
UXcwU2w1Ukc5QnE0QTZMZU9PcnFMNi95aXFzQzJlNndaOTZJTFRub0xQRQpFQkNIK1hoeGQxbWFa
eHByWnEzYTVqeDE1NHRBUGpYZlRhaE40b0djSzdKcE5sNlNZa280VVFDVDR6ZzYzeFl1CjdkSjlS
YXZsNndrWFFrQWVrM2YzZE00SzhLM3cxekwrKys3dnRyeERyUWN3YmE2MHVFU0pJU3lSWWFHd1Y1
bTEKNk5zOHBrUWdzWGFVMUpvbU13WjNSUDBoNThTR0N6Tk9mQ1B4ZGlLaTdRQ2E1RUJYbVlITkxZ
Z1NRbmUxTnlsSgpDa2JUYkpHYWowQ2liYklHZjNMK3dRakx5cGh6Z01kcDR2QnI1bVRPTWNTU1dQ
V3I4OTY1OFhoaEQ3bWpKbTBmCkJ5VllKOThDOE1nbFltVkxwd2F1MWYrRkJKdElvZTBMQUJFQkFB
R0pBVHdFR0FFSUFDWVdJUVE2cnRvSGl0SU4KUmIxT3IxREMwUVlMcnNoeHZ3VUNXcnBTaEFJYkRB
VUpBZUV6Z0FBS0NSREMwUVlMcnNoeHY4SjdCLzBZK3FiMApLRUtZSjU0NzY1SXFheDRHVTZyaXpz
cXhWZkphUTJXdzFNNS92OE1nMm5JcDBnRHZpWmFtY0tuRm83SFJQN3kyClJoQWZRRzhvd0JqU2oz
dzJmRDhoU1dmRVhTb1N0bjBHYTJsQzRyc3ZiZnd3N0dVVVBEeGJBekdRKzNBZGJWMjgKK0thQXhB
SGZLWlpzN1NXUmpyZW1xWDBVS2dFWDJWZDk4MWx2cng1NUFIeFVMTHpMbWlYc1dUT21vSDQwMmR6
ZwpXRENvWDlPbVo1aEhLdlJuT2hKL29Jczd2M0NrWFJOU3QwbnUyVFRzSzN4MXJWMUxBZTJSMTFy
K2ordlVZL3hLCkJUa21NRlZrOFhCSHVFTC9BZWlRM0c1UUFyS2RKSCt3VzF6SGhvMzAzOFZzQjBw
Qk52dHZPdXdlRTB5UzY1alAKYlhHRlNheEQ3d3NXR2lISAo9RmxaWQotLS0tLUVORCBQR1AgUFVC
TElDIEtFWSBCTE9DSy0tLS0tCg==

--===============8050653932754447808==--

