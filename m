Content-Type: multipart/mixed; boundary="===============8587977104605712010=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCHv2] plugin: Add ste modem initd integration
Date: Tue, 21 Dec 2010 16:37:56 +0100
Message-ID: <AANLkTinzVf3RqGhWW_=4g=epYMCsihfqe-EL=epg=oE5@mail.gmail.com>
In-Reply-To: <1292944723.2658.51.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8587977104605712010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

>> > This is a bad D-Bus API btw. Using a D-Bus method to trigger signal
>> > sending. You will wake up any listener for that signal. What is wrong
>> > with just having a GetState?
>>
>> My problem is that I need to get the path, or modem serial-number if
>> you like, to the
>> modem(s). As I don't know the start order I have to query the state at s=
tartup.
>> So this will happens only once. The simples way for me to get the path is
>> to send "ResendState" to path "/". This will then send the state info
>> for all modem
>> paths.
>>
>> I don't think I have the path them available at connect...
>> If you have any other ideas of how to query the modem instances I'm all =
ears?
>
> I think you need to resend the D-Bus API of your init daemon. I need to
> have a second look.

This is an extract of the Modem Init Daemon D-Bus API.
I have removed the GetState API as we don't know the object
path of the modem when oFOno has just booted. Instead we
have added the ResendState API. This will be called initially
when oFono starts to query the modem instances and their
state. After startup state changes are handed as signals
with StateChange. (There are some exceptions to this but
they should be only corner cases).


Modem Init Deamon
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Service com.stericsson.modeminit
Interface       com.stericsson.modeminit.Modem
Object path     /{modem-serial} or /

Methods
		void  ResendState()

                      Resends state information for all modems.
		      This method must use with '/' as object path.

		string GetCaifIfName()

                      Returns the CAIF Link Layer interface used for
		      AT channels for a specific modem. This method
		      must use the same object path as used in StateChange.


Signals  StateChange(string status)

                       The modems state sent from Modem Init Daemon when
                       a modem state change occurs. The object path must
		       be the identifier of the modem (typically
                       the serial-id or IMEI of the HW).

                       "booting"   Modem is powered up (flashed version)
                                   or Modem is powered up and firmware uplo=
ad
                                   is completed. (flashless version)
                       "upgrading" Firmware upgrade on going
                                   or Flashing manager under execution -
                                   modem in service mode.
                       "on"     Modem has booted and is ready for use.
                                   This implies that all AT channels are
                                   available, the modem might be in
                                   e.g. flight mode.
                       "dumping"  Modem has crashed and dump is ongoing
                       "off"       Modem is powered off.


Regards,
Sjur

--===============8587977104605712010==--

