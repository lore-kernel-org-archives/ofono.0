Content-Type: multipart/mixed; boundary="===============7445424080953573672=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SIMCOM support
Date: Thu, 24 Jan 2013 10:21:56 -0600
Message-ID: <51015FA4.4050300@gmail.com>
In-Reply-To: <51012DAB.9000108@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7445424080953573672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 01/24/2013 06:48 AM, Viallard Anthony wrote:
> Hello ofono guys,
>
> I've got a embedded device with SIM5216E modem. Based on the previous
> work done by my colleague Jean-Christian de Rivaz (you can see previous
> talk on this mailing list about this modem "Some experiments with the
> SIMCOM SIM5216E modem on a ARM926 board"), the simcom AT doc, my
> MacGyver kit and my resourcefulness, i do a patch for ofono to support
> this modem (and maybe others models).

How closely related is this one to SIMCOM 900?  We already do have a =

plugin for it in the tree, so it might be a good idea to merge the two =

if they are closely related.

>
> I attach the patch to this email.

Please use git send-email to send patches.

>
> While making this patch, I wondered about that :
>
> * After entering a pin code, ofono goes too fast and checks too early
> the sim pin status with "CPIN?". The ME responds "CME Error : 14 (SIM
> busy)" and ofono stops here. Ofono doesn't send more CPIN? or intercept
> the "+CPIN: READY" that the modem send after a while when SIM is back
> online. So, I use the same workaround that for ZTE : sending severals
> AT+CPIN? commands during 20 seconds until having "+CPIN: READY". It
> works well but as my modem sends the "+CPIN: READY" from its own, I
> think I can use another mechanism more "standard" in ofono, isn't it ?
>

oFono core expects the sim atom driver to return from PIN entry function =

when the SIM initialization procedures have been completed.  Many modems =

have an unsolicited notification that is fired when this is done, to =

avoid CPIN? polling.  Are you saying your modem fires off a 'CPIN: =

READY' as an unsolicited notification?  If so, then you can follow the =

same type of mechanism as VENDOR_IFX or VENDOR_STE

> * I want to save power when i doesn't need the modem. So, i guess it is
> the purpose of the "org.ofono.Modem.SetProperty" dbus method and the
> setting "Powered". When I set "Powered" to "False", I see ofono calls
> the "disable" callback of "struct ofono_modem_driver", so I think its
> here I must write the famous CFUN command(s) to put modem down. In the
> AT doc for SIMCOM, I have severals CFUN values for, i think, disable
> purpose :
>
> 0 =E2=80=93 minimum functionality
> 4 =E2=80=93 disable phone both transmit and receive RF circuits
> 7 =E2=80=93 Offline Mode

oFono expects the following:

Powered =3D True, Online =3D True -> Full functionality
Powered =3D True, Online =3D False -> RX/TX circuits down, SIM Card reader =

enabled
Powered =3D False -> Everything is powered down.

>
> For now, i do a CFUN=3D4 but maybe i need to do more and add CFUN=3D7 ? Or
> maybe use CFUN=3D0 ?
>

You would need to find out what exactly those modes do.

> Can the "disable" callback be called by ofono in other case and so, i
> must only do a CFUN=3D4 ?
>

disable is performed when the modem is powered down, either by normal =

means or when oFono daemon shuts down.

> * I would like to do a reset of the modem at start and at end of ofono
> life (with AT+CFUN=3D6 or AT+CRESET). The purpose is having a modem always
> in init state for ofono and the others programs. Do you think its a good
> idea ?
>

In general that is not desirable.  The modem should be initialized when =

the enable driver method is called.  Why do you want to do this?

Regards,
-Denis

--===============7445424080953573672==--

