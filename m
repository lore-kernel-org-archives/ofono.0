Content-Type: multipart/mixed; boundary="===============3662949100232540890=="
MIME-Version: 1.0
From: Bob Ham <bob.ham@puri.sm>
Subject: Re: Voice calls over qmi was Re: Incoming sms problem on Motorola
 Droid 4
Date: Wed, 16 May 2018 16:10:55 +0100
Message-ID: <717eeff6-6c39-5475-c3ab-7588cf7e2def@puri.sm>
In-Reply-To: <20180512073752.GD9313@nataraja>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3662949100232540890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/05/18 08:37, Harald Welte wrote:

> As there are no modems that reliably can deliver the actual audio data vi=
a USB
> (aside some non-supported outdated experimental firmwares), we're only te=
sting
> the signaling plane so far.

Hi Harald,

I'm alarmed to see this statement.  Can I ask what you mean here when =

you say "no modems"? :-)  Do you mean on the market in general?

I've been using the SIMCom SIM7100E which is specified as supporting =

audio data over a USB serial connection.  Unfortunately I've had a lot =

of trouble getting it to work but I've been collaborating with Stanislav =

Sinyagin (CC'd) who has a SIM7100E with an earlier firmware and who can =

reliably get audio by dd'ing /dev/ttyUSBX.  I'm waiting on our supplier =

to get the same firmware version.

There are earlier SIMCom modems with application notes describing how to =

get audio over USB too, for example the SIM5360.

Regards,

Bob

--===============3662949100232540890==--

