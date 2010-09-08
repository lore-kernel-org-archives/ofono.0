Content-Type: multipart/mixed; boundary="===============4622945794449772304=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [online-impl-v2 PATCH 00/10] implement Online property
Date: Thu, 09 Sep 2010 01:36:13 +0200
Message-ID: <1283988973.6640.141.camel@localhost.localdomain>
In-Reply-To: <1283798780-16363-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4622945794449772304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> Here are 2nd stab at implementing Online property with various modem
> drivers.

so I pushed most of them, but not all of them.

STE version needs testing by the STE guys, but I did run into some SIM
not ready issues with MBM when switching online/offline a few times. So
that needs to be looked into.

I did leave Palm Pre and G1 patches out. Andrew is the best candidate
for testing these. I have no idea on how they behave.

> Some more obvious errors (in using g_at_chat_send()) have been
> fixed. Huawei has been updated after the comment from Marcel.

The Huawei has more and more issues with SIM not ready now. This needs
fixing anyway. I pushed the patch anymore to make these symptoms more
clear to everybody.

> I've dropped support for the Nokia usb stick, according to the spec it
> does not implement but AT+CFUN=3D0 and AT+CFUN=3D1. (Not that I have test=
ed
> what AT+CFUN=3D0 does.)

I have that stuck, but that beast is broken like crazy. The firmware has
even a bug with AT+COPS :(

> Again, I have not been able to test with most modems. All of them might
> not make sense (if the modem does not support AT+CFUN=3D4, for
> instance). There might be some common caveats.  E.g., if the modem does
> to wake up with AT+CFUN=3D4, it might work with an initial cfun command
> like "AT+CFUN=3D1 ; +CFUN=3D4". At least Calypso requires such an
> initialization command.
> =

> I'd appreciate if the people with access to various hardware could test
> them with the patches here (using test/enable-modem, test/online-modem
> and test/offline-modem, or, e.g., the connman with "ofono-refactor-v2"
> and "service-leak" patches).

I have done basic testing and so far so good. Huawei and MBM needs
further attention for sure. I am more than shocked that I actually do
have all this crap hardware on my desk :(

Regards

Marcel



--===============4622945794449772304==--

