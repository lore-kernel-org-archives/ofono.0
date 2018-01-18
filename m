Content-Type: multipart/mixed; boundary="===============5013574986673295703=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei MS2131
Date: Thu, 18 Jan 2018 11:03:29 -0600
Message-ID: <4383ec18-50d2-1ed2-c9a8-7305b7c155b1@gmail.com>
In-Reply-To: <1c0a7b68-d2f7-6681-a248-b49404696b58@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5013574986673295703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 01/18/2018 06:32 AM, Daniel Wagner wrote:
> [16:18:50.215180] ofonod[3277]: Modem: < \r\n+CGREG: 1,"03B8","0EA971F9"\=
r\n
> [16:18:50.315482] ofonod[3277]: Modem: < \r\n^SRVST: 2\r\n
> [16:18:50.498603] ofonod[3277]: Modem: < \r\n+CREG: 1,"03B8","0EA971F9"\r=
\n
> [16:19:39.357779] ofonod[3277]: Modem: < \r\n+CSQ: 27,99\r\n\r\nOK\r\n
> [16:19:39.357843] ofonod[3277]: Modem: > AT&C0\r

You do seem to get network registration there at the end, but they only =

come on the Modem Port which is weird.  Also that last AT&C0 should be =

located right around the same place as the AT&C0 on the PCUI port, not =

much later in the log as it is now.  They're sent at the same time in =

sysinfo_enable_cb.

Something is weird with that hardware, almost like the Modem port isn't =

ready to send commands until much later.  Are you sure you have udevng =

detecting the right AT ports?

Regards,
-Denis

--===============5013574986673295703==--

