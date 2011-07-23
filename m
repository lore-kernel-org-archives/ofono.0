Content-Type: multipart/mixed; boundary="===============9074940944084408250=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 2/3] cdmamodem: Create network registration atom.
Date: Sat, 23 Jul 2011 10:11:05 -0500
Message-ID: <4E2AE489.2070103@gmail.com>
In-Reply-To: <1311433175.21109.346.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9074940944084408250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

<snip>

>> +#include "gatchat.h"
>> +#include "gatresult.h"
>> +
>> +#include "common.h"
> =

> I know that you are re-using the GSM network registration constants here
> and thus need common.h.
> =

> Denis, is this acceptable for you?
> =


No, not really.  Since CDMA has no defined standard API these should
probably be an enum inside cdma-netreg.h

<snip>

>> +static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>> +{
>> +	struct ofono_cdma_netreg *netreg =3D user_data;
>> +	gint service_state;
>> +	gint service_domain;
>> +	gint roaming_state;
>> +	int status;
>> +	GAtResultIter iter;
>> +
>> +	if (!ok)
>> +		return;
>> +
>> +	g_at_result_iter_init(&iter, result);
>> +
>> +	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
>> +		return;
>> +
>> +	if (!g_at_result_iter_next_number(&iter, &service_state))
>> +		return;
>> +
>> +	if (!g_at_result_iter_next_number(&iter, &service_domain))
>> +		return;
>> +
>> +	if (!g_at_result_iter_next_number(&iter, &roaming_state))
>> +		return;
>> +
>> +	switch (service_state) {
>> +	case 0:
>> +	case 4:
> =

> Please put at least comments behind every case label so that we know
> what it does mean.
> =

>> +		status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
>> +		break;
>> +	case 2:
>> +		if (roaming_state)
>> +			status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
>> +		else
>> +			status =3D NETWORK_REGISTRATION_STATUS_REGISTERED;
>> +		break;
>> +	default:
>> +		status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
>> +		break;
>> +	}
>> +
>> +	ofono_cdma_netreg_register(netreg);
>> +
>> +	ofono_cdma_netreg_status_notify(netreg, status);
>> +}
> =

> How do we get unsolicited notification when the status changes?
> =


And why are we using a Huawei specific command inside the generic
cdmamodem driver without at least a vendor if/switch somewhere?

Regards,
-Denis

--===============9074940944084408250==--

