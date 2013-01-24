Content-Type: multipart/mixed; boundary="===============8941246940501714269=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: SIMCOM support
Date: Thu, 24 Jan 2013 18:13:28 +0100
Message-ID: <51016BB8.7090403@syscom-instruments.com>
In-Reply-To: <51015FA4.4050300@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8941246940501714269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 24. 01. 13 17:21, Denis Kenzior wrote:

> How closely related is this one to SIMCOM 900? We already do have a
> plugin for it in the tree, so it might be a good idea to merge the two
> if they are closely related.

I don't known if SIM900 works with my driver plugin. SIMCOM were not =

given us this information whereas we inquired them. It will be glad if =

someone check it.

The only main difference i see between the two plugins, it's the =

AT+CSCS=3D"GSM" command. I don't exactly why there is this command. Maybe =

its a behavior need it to work correctly with the operator where the guy =

has wrote the code and done the test. If someone tell me how to check =

(with an AT command ?) if we need this command, I will do the job.

In the SIMCOM doc, I see this about AT+CSCS :

  - =E2=80=9CIRA=E2=80=9D : International reference alphabet.
  - =E2=80=9CGSM=E2=80=9D : GSM default alphabet; this setting causes easil=
y software =

flow control (XON /XOFF) problems.
  - =E2=80=9CUCS2=E2=80=9D 16-bit universal multiple-octet coded character =
set; UCS2 =

character strings are converted to hexadecimal numbers from 0000 to FFFF.

>
> Please use git send-email to send patches.
>

ok.

> oFono core expects the sim atom driver to return from PIN entry function
> when the SIM initialization procedures have been completed. Many modems
> have an unsolicited notification that is fired when this is done, to
> avoid CPIN? polling. Are you saying your modem fires off a 'CPIN: READY'
> as an unsolicited notification? If so, then you can follow the same type
> of mechanism as VENDOR_IFX or VENDOR_STE
>

Right. My modem fires off a 'CPIN: READY' as an unsolicited =

notification. I will check the VENDOR_IFX or VENDOR_STE mechanism.

>> * I would like to do a reset of the modem at start and at end of ofono
>> life (with AT+CFUN=3D6 or AT+CRESET). The purpose is having a modem alwa=
ys
>> in init state for ofono and the others programs. Do you think its a good
>> idea ?
>>
>
> In general that is not desirable. The modem should be initialized when
> the enable driver method is called. Why do you want to do this?

I guessed it will be nicer to have this but if you say no, ok, it was =

just an idea to have always a chips in same state at start and when =

ofono stops.

Thanks,
avd.


--===============8941246940501714269==--

