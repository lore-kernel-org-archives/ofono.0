Content-Type: multipart/mixed; boundary="===============0817916907302621749=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] plugins: new driver for u-blox SARA-U270 modems
Date: Thu, 26 Jun 2014 10:35:11 -0500
Message-ID: <53AC3DAF.304@gmail.com>
In-Reply-To: <20140626144934.GT33006@rincewind.trouble.is>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0817916907302621749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 06/26/2014 09:49 AM, Philip Paeps wrote:
> On 2014-06-26 09:29:51 (-0500), Denis Kenzior <denkenz@gmail.com> wrote:
>>> +static void ublox_remove(struct ofono_modem *modem)
>>> +{
>>> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
>>> +
>>> +	DBG("%p", modem);
>>> +
>>> +	ofono_modem_set_data(modem, NULL);
>>> +	g_at_chat_unref(data->aux);
>>
>> Any reason data->modem is not being unrefed? e.g in the case of hot-unpl=
ug?
> =

> As far as I can tell, disable is always called before remove.  In the
> hot-unplug case, ofonod -d output goes:
> =

> ofonod[680]: src/gprs.c:gprs_remove() atom: 0x1443220
> ofonod[680]: src/sim.c:sim_remove() atom: 0x1442fb0
> ofonod[680]: src/modem.c:devinfo_remove() atom: 0x14425a0
> ofonod[680]: plugins/ublox.c:ublox_disable() 0x143ba00
> ofonod[680]: plugins/ublox.c:ublox_remove() 0x143ba00
> ofonod[680]: src/modem.c:unregister_property() property 0x143bb00
> ofonod[680]: src/modem.c:unregister_property() property 0x14448e0
> =

> Am I missing something?
> =


ofono_modem_remove calls disable() only if the modem is powered.  So in
cases of e.g. modem still being powered up, disable() won't be called.

Regards,
-Denis

--===============0817916907302621749==--

