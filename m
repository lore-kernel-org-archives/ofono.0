Content-Type: multipart/mixed; boundary="===============6671978865775857115=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: connection manager interface
Date: Wed, 15 Oct 2014 14:46:26 -0500
Message-ID: <543ECF12.60707@gmail.com>
In-Reply-To: <CAOD0pen=wcBtCmRJw0iA40VioyRqiKN2u6F02dGv_0mk8dmDrA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6671978865775857115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ernast,

On 10/14/2014 02:00 PM, Ernast Sevo wrote:
> Perfect! That clears things up a bit!
> Once in the online state will the Packet Radio Service always be
> attached? Ive noticed it at times that its not attached (even though
> packet radio use is allowed ie Powered=3DTrue in

Two settings control the attachment state.  Powered and RoamingAllowed. =

  If RoamingAllowed is false, then if the network registration is =

currently in roaming state, the GPRS will detach / not attach.

> org.ofono.ConnectionManager) and that I cannot manually attach it which
> is something is doable via an AT command. Or does calling enable gprs
> automatically attach it? Is there a way to manually attach it through ofo=
no?

Attachment cannot be done manually. oFono should re-attach automatically =

if it is able.  There might be a few corner cases (e.g. where a network =

forced a detach) which we do not handle.

Patches / logs are always welcome.

Regards,
-Denis

--===============6671978865775857115==--

