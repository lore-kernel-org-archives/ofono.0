Content-Type: multipart/mixed; boundary="===============4546893177217421630=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono DUN server issue
Date: Thu, 14 Jun 2012 17:46:34 -0500
Message-ID: <4FDA69CA.5080100@gmail.com>
In-Reply-To: <20120615025829.GB3538@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4546893177217421630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

>>> We actually don't have an client uuid for DUN, and we need to put the s=
erver
>>> uuid here in order to find the remote DUN Gateways.
>>> Other than that he reported an issue in oFono, so how can dundee interf=
ere on
>>> it?
>>
>> I'm just speculating, but the problem here is that both dundee and
>> the modem emulator are registering the DUN service.  Unfortunately
>> dundee is implementing the client role and modem emulator is
>> implementing the server role.
>
> They aren't, DUN server register a server, through
> bluetooth_register_server(), there is no UUID on this. Only DUN Service
> register itself as DUN on BlueZ.
>
>>
>> Perhaps dundee does not need to register an SDP record at all.  I'm
>> too lazy to dig out the DUN spec.
>
> It doesn't need because it doesn't have one. We use DUN_GW_UUID here beca=
use
> we want plugins/bluetooth.c to notify us when a DUN_GW device appears so =
then
> we can use or DUN Client (dundee) to connect to it.
>
> HFP does the same, in the Handsfree side we register for the UUID of the
> Gateway side because you want to know about new HFP  gateways on the syst=
em.
>

Fair enough.  Then I have no idea what is causing this regression.

Regards,
-Denis

--===============4546893177217421630==--

