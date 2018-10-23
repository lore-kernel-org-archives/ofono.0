Content-Type: multipart/mixed; boundary="===============7618923849163009105=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH] src/modem: connection timeout to 60 seconds
Date: Tue, 23 Oct 2018 12:45:01 +0200
Message-ID: <d27aeefc-d5fe-5ec6-1af6-650e14deeb68@norrbonn.se>
In-Reply-To: <CAKSBH7FhE7LKByNODgqqXQTdna37_f6cVxPvSY5PxnG3kwKYfA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7618923849163009105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 23/10/18 11:26, Giacinto Cifelli wrote:
> Hi Jonas
>>
>> This is where I think adding a data item in udevng would be in order.
>> ...set_int(..., "PoweredTimeout", 60)... or something like that.  It's a
>> device quirk, after all.  I've dealt with modems that were slow to boot,
>> but usually they don't present the USB interfaces until they are ready
>> to go.
> =

> I had in mind a plugin function that would return the timeout it needs
> (to be called between .probe and .enable), something like .get_params.
> =

> Your parameter should be set in a udev rule, otherwise it would apply
> to all modems connected, and so it is marginally better than the
> current hardcoding.
> Adding udev rules is tedious, USB devices are supposed to work 'out of
> the box', without manual tweaks.

No, not in a udev rule.  I was thinking of adding a line like this to =

setup_gemalto() in plugins/udevng.c:

if (g_strcmp0(modem->model, "xxxx"))
	ofono_modem_set_int(modem->modem, "PoweredTimeout", 60);

('model' is hexadecimal, numeric value, so you could parse it and do a =

switch() on it if you don't like the strcmp...)

Then query the setting in src/modem.c.

/Jonas

--===============7618923849163009105==--

