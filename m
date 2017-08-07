Content-Type: multipart/mixed; boundary="===============2098531831270946946=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: gemalto: AGPS functionality
Date: Mon, 07 Aug 2017 15:04:33 -0500
Message-ID: <06d04f18-edfb-6ade-0fb3-17883ede7dcc@gmail.com>
In-Reply-To: <666978a8d452d99f673b8a28a5332e75@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2098531831270946946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 06/21/2017 06:45 AM, Vincent CESSON wrote:
> Hi,
>
> I am trying to add AGPS functionality to Gemalto modems. I took a look
> at interface AssistedSatelliteNavigation and implementation in
> drivers/atmodem/gnss.c. Unfortunately, Gemalto does not support AT+CPOS
> command but it uses a custom command: AT^SBNW. Moreover, the positioning
> file expected is not XML but binary format.

When we designed the API many years ago, the assumption was that the =

vendors would utilize the standardized CPOS command, guess that never =

happened.

>
> The process of loading the binary is:
>  - Download binary file from Gemalto server to local memory
>  - Initiate binary write command: AT^SBNW=3D"agps",<binary_file_length>
>  - Copy binary file from local memory to modem over its application (or
> modem) interface
>
> AT^SBNW immediately returns "CONNECT". Then "AGPS READY: SEND FILE..."
> After the modem receives the exact amount of bytes specified in the
> command, it verifies the data and returns one of the following: "AGPS
> END OK", "TIME INFO ERROR", "BAD CRC" or "OK".
>
> So I am facing several issues:
>  - How to send binary data from local memory to oFono? DBus message with
> array of bytes?

Yes, that would be one way.

>  - How to send binary data from oFono to modem interface? Does gatchat
> only support strings?

You would have to use something similar to GAtPPP.  E.g. using =

g_at_chat_suspend to suspend GAtChat processing after receiving the =

CONNECT and having some other object take over the GAtIO.  See how =

setup_ppp works in drivers/atmodem/gprs-context.c

>  - How to handle custom result codes? I already tried some hacks, and I
> had to blacklist the response "CONNECT" for instance.

You can use g_at_chat_add_terminator and g_at_chat_blacklist_terminator.

>
> Or maybe it isn't worth the effort implementing it in oFono?
>

Is the Gemalto AT commands functionally equivalent to +CPOS/+CPOSR?  If =

so, then maybe we can try to tweak the API.  If this is something =

custom, then perhaps utilizing a gemalto specific DBus interface would =

be the way to go.  See the ThermalManagement vendor specific API inside =

plugins/ril_intel.c for an example of how to accomplish this.

Regards,
-Denis

--===============2098531831270946946==--

