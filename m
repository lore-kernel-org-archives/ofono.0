Content-Type: multipart/mixed; boundary="===============9101870028645148460=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH 3/4] Fix: Avoid release dialing call when call is 0
Date: Mon, 16 Nov 2009 22:18:36 +0800
Message-ID: <1258381116.5437.7.camel@zzhan17-mobl.ccr.corp.intel.com>
In-Reply-To: <1258380741.5437.2.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9101870028645148460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, 2009-11-16 at 22:12 +0800, Zhenhua Zhang wrote:
> If +CIEV call goes to 0, we may have another dialing call. We
> should not release this dialing call when call=3D0.
> ---

Here's one example to explain how it could happen. we have two
calls: active A and dialing B. If A is released by remote, B
should not be released. But now we released both of them at
 ciev_call_notify().

Below is the detailed log. A is 10086 and B is 61167086.
--------
ofonod[4508]: > ATD61167086;\r
ofonod[4508]: < \r\nOK\r\n
ofonod[4508]: atd_cb got result: 1
ofonod[4508]: Final response: OK
ofonod[4508]: < \r\n+CIEV: 3,2\r\n
ofonod[4508]: > AT+CLCC\r
ofonod[4508]: < \r\n+CIEV: 7,1\r\n
ofonod[4508]: Got a voicecall event, status: 1, id: 1, number: 10086
ofonod[4508]: Found call with id: 1
ofonod[4508]: < \r\n+CLCC: 1,0,1,0,0,"10086",129,"10086 (Mobile)"\r\n
ofonod[4508]: < \r\n+CLCC: 2,0,2,0,0,"61167086",129\r\n
ofonod[4508]: < \r\nOK\r\n
ofonod[4508]: sync_dialing_cb got result: 1
ofonod[4508]: Final response: OK
ofonod[4508]: Response line: +CLCC: 1,0,1,0,0,"10086",129,"10086
(Mobile)"
ofonod[4508]: Response line: +CLCC: 2,0,2,0,0,"61167086",129
ofonod[4508]: Got a voicecall event, status: 2, id: 2, number: 61167086
ofonod[4508]: Did not find a call with id: 2
ofonod[4508]: < \r\n+CIEV: 3,3\r\n
ofonod[4508]: Got a voicecall event, status: 3, id: 2, number: 61167086
ofonod[4508]: Found call with id: 2
ofonod[4508]: < \r\n+CIEV: 2,0\r\n
ofonod[4508]: Got disconnection event for id: 1, reason: 2
ofonod[4508]: Got disconnection event for id: 2, reason: 2
ofonod[4508]: < \r\n+CIEV: 7,0\r\n
ofonod[4508]: > AT+CLCC\r
ofonod[4508]: < \r\n+CLCC: 2,0,3,0,0,"61167086",129\r\n
ofonod[4508]: < \r\nOK\r\n
ofonod[4508]: clcc_poll_cb got result: 1
ofonod[4508]: Final response: OK
ofonod[4508]: Response line: +CLCC: 2,0,3,0,0,"61167086",129
ofonod[4508]: Got a voicecall event, status: 3, id: 2, number: 61167086
ofonod[4508]: Did not find a call with id: 2
ofonod[4508]: Warning: Call id and internally tracked id do not
correspond






--===============9101870028645148460==--

