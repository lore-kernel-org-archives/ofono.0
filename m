Content-Type: multipart/mixed; boundary="===============5995173127734101842=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Telit LE910V1 - LTE only modem
Date: Mon, 20 Mar 2017 18:39:55 -0500
Message-ID: <9039a556-efd6-4c8c-a6ad-d7a4291325b9@gmail.com>
In-Reply-To: <a9342863-3841-ee82-b423-4bdb32d26798@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5995173127734101842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

>> Strictly speaking this statement is correct.  In LTE there's really no c=
oncept of 'attached'.  We're attached by the virtue of getting onto the LTE=
 network (the default bearer is always available).  So there should be no n=
eed to explicitly issue a set_attached method.
>
> The current qmimodem code, calls ofono_gprs_status_notify(NETWORK_REGISTR=
ATION_STATUS_REGISTERED) when it receives a notification from the modem tha=
t it is fully connected. Is that the correct path to make the gprs context =
marked as "attached"?
> If that does not happen, all the dbus context APIs just return an error, =
and as a result, e.g. connman does not enable the cellular service.
>

So as it is today, oFono for LTE expects the following:
ofono_gprs_status_notify(with registered / roaming)
and ofono_gprs_cid_activated() for the default bearer.

The gprs-context driver must then implement read_settings method.  LTE =

is weird since the contexts can be network activated.  The default =

bearer is 'activated' by the modem firmware itself by virtue of =

obtaining the LTE network registration.  The logic is quite different =

compared to 2G/3G.

If you know your AT commands, see how the ubloxmodem driver does this. =

Pay attention to drivers/atmodem/gprs.c cgev_notify() and =

drivers/ubloxmodem/gprs-context.c.

We also now have an lte atom.  See doc/lte-api.txt for details.

If the above isn't possible for QMI, then we might need to tweak the =

core logic (e.g. src/gprs.c) accordingly.

Please note that qmimodem driver was developed when we didn't have lte =

support, so the logic in there is probably incorrect / inadequate.

> I can add a change to qmimodem, which will explicitly ask the modem firmw=
are if it is connected, from qmi_gprs_probe() rather than waiting on a stat=
e change notification, which never arrives.
> Does that make sense?
>
> How do you usually test such changes for regressions? I do not have any o=
ther QMI modems, to verify if I have broken anything in them or not. I thin=
k the change should be safe, but I cannot be 100% certain.
>

We try to catch most regressions during the patch review process.  In =

the past we had some QA resources performing manual tests, but these =

resources are no longer available.  Easiest might be to order a few qmi =

modems and check if your patches break them :)

Regards,
-Denis

--===============5995173127734101842==--

