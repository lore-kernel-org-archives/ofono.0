Content-Type: multipart/mixed; boundary="===============0715108820802220968=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Provisioning mechanism
Date: Sun, 06 Apr 2014 19:00:53 -0500
Message-ID: <5341EAB5.7050105@gmail.com>
In-Reply-To: <CAM5ihG98uDdODn4_UXuB=FhwGwT=U0-0YeT3TNzAxPXvA0HdPA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0715108820802220968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jer=C3=B4nimo,

On 04/06/2014 02:37 PM, Jer=C3=B4nimo Lopes wrote:
> Hi,
> =

> I'm trying to understand ofono build-in provisioning mechanism.
> =

> As far as understand these are the steps:
> =

> 1: get MCC and MNC
> 2: check settings file for this network, if exists goto step 6
> 3: try to read provisioning info from the sim card, if ok, goto step 5
> 4: try to read provisioning from MBPI xml file
> 5: write info to the settings file =

> 6: if it has a valid provisioning info, "export" (I don't know if this
> is the right term, so I'll use it) it to connman.
> =

> So my first question, is that correct?

Nope, not really.

The process is roughly like this:
- Load settings file.  Settings are stored according to IMSI of the SIM
- If no settings file is found, wait until MCC, MNC and SPN are known
- Run provisioning plugins (e.g. MBPI)
- If provisioning fails, make up a 'sentinel' context telling external
parties that no valid settings exist.

> =

> The other question is why provisioning plugin can't get 2 or more apn
> settings for the same network and export more than one service to connman?
> =

> I've tried to change line 53 of plugins/provision.c, setting
> 'allow_duplicates' parameter to 'TRUE':
>  apns =3D mbpi_lookup_apn(mcc, mnc, TRUE, &error);
> =

> Everything seams to work, but only the first context is exported to
> connman. I've try to debug the code, but I could't realize where this is
> done. =

> Is there a particular reason why this can't be done?

oFono can.  Connman only expects to manage a single Internet context, so
having multiple will not work there.

Regards,
-Denis

--===============0715108820802220968==--

