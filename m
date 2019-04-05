Content-Type: multipart/mixed; boundary="===============0849570259149556614=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: return all serial numbers
Date: Fri, 05 Apr 2019 17:04:12 -0500
Message-ID: <a9efe2bc-0c95-885d-dc13-2b5f32cda183@gmail.com>
In-Reply-To: <46465886edbd45a3bc563ee11286575f@garmin.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0849570259149556614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On 04/05/2019 03:13 PM, Nguyen, Tom wrote:
> Hi Denis,
> =

> Thank you for the quick response. By the way, I'm not able to post to ofo=
no(a)ofono.org, so this reply probably won't show up there. I've not figure=
d out what the problem is, but suspect it's blocking "garmin.com".

Please contact ofono-owner address again and see if someone can help.  I =

don't really have any idea why we would be blocking any domain and you =

are the first to complain in 10 or so years.

> =

> The issue is that Quectel has a single mode LTE modem that populates all =
3 fields. They do this because they also have the same modem that only supp=
orts CDMA. So, the current oFono code returns the ESN even though my modem =
is LTE only. Your info below is very informative, thanks! The CDMA info als=
o confirms my observation about its level of support.
> =

> I have an alternative idea. What if I query QMI_DMS_GET_CAPS, figure out =
which radio_if is supported, then return IMEI if GSM/UMTS/LTE is supported,=
 else ESN or MEID? This way Modem.Serial property will still behave as it d=
oes now.

That sounds workable.

Regards,
-Denis

--===============0849570259149556614==--

