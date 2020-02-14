Content-Type: multipart/mixed; boundary="===============6064335338117197890=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] ublox: network-registration: Handle UREG unsolicited
 during poll
Date: Fri, 14 Feb 2020 11:27:25 -0600
Message-ID: <7dd14ae2-730c-9214-9bb2-646f15b11cc6@gmail.com>
In-Reply-To: <20200214090601.21727-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6064335338117197890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 2/14/20 3:06 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> In the case a unsolicited indication for UREG was received
> while the status was polled. The poll response failed to parse.
> This since the unsolicited indication only carries one
> parameter, while the poll response is expected to carry two.
> =

> Update the code to loop until the response is found.
> =

> The log below shows a case where this happened.
> =

> 10:07:55 ofonod[520]: Aux: > AT+UREG?\r
> 10:07:55 ofonod[520]: Aux: < \r\n+CGREG: 4\r\n\r\n+UREG: 0\r\n\r\n+CIEV: =
9,1\r\n
> 10:07:55 ofonod[520]: src/gprs.c:ofono_gprs_status_notify() /ublox_0 stat=
us unknown (4)
> 10:07:55 ofonod[520]: src/gprs.c:ofono_gprs_detached_notify() /ublox_0
> 10:07:55 ofonod[520]: Aux: < \r\n+UREG: 1,0\r\n
> 10:07:55 ofonod[520]: Aux: < \r\nOK\r\n
> ---
>   drivers/ubloxmodem/network-registration.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> =


Applied with a minor whitespace fix.

Regards,
-Denis

--===============6064335338117197890==--

