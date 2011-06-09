Content-Type: multipart/mixed; boundary="===============4041521262288784909=="
MIME-Version: 1.0
From: jeevaka.badrappan@linux.intel.com
Subject: Re: [PATCH] ifxmodem: emergency number list support
Date: Thu, 09 Jun 2011 06:44:45 -0700
Message-ID: <63214.10.254.193.112.1307627085.squirrel@linux.intel.com>
In-Reply-To: <4DED5CEF.8020205@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4041521262288784909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> +
>> +	if (!g_at_result_iter_next_number(&iter, &total_cnt))
>> +		return;
>> +
>> +	if (!g_at_result_iter_next_string(&iter, &number))
>> +		return;
>> +
>> +	/* Skip the category, valid in simpresent and mcc fields */
>
> What is this comment referring to?

Following fields like category, valid in sim present state and mcc are
skipped as we are not going to use it. Just for information purpose.
I'll remove the comment.

>
>> +
>> +	if (vd->en_list =3D=3D NULL)
>> +		vd->en_list =3D g_new0(char *, total_cnt + 1);
>> +
>> +	vd->en_list[count] =3D g_strdup(number);
>> +
>> +	if (index !=3D total_cnt)
>> +		return;
>> +
>> +	ofono_voicecall_en_list_notify(vc, vd->en_list);
>> +
>> +	g_strfreev(vd->en_list);
>> +	vd->en_list =3D NULL;
>> +}
>> +
>> +static void xlema_read(gboolean ok, GAtResult *result, gpointer
>> user_data)
>> +{
>> +	struct ofono_voicecall *vc =3D user_data;
>> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
>> +	GAtResultIter iter;
>> +	int num =3D 0;
>> +	int index, total_cnt;
>> +	const char *number;
>> +
>> +	if (!ok) {
>> +		DBG("Emergency number list read failed");
>> +		return;
>> +	}
>> +
>> +	g_at_result_iter_init(&iter, result);
>> +
>> +	while (g_at_result_iter_next(&iter, "+XLEMA:"))
>> +		num +=3D 1;
>> +
>> +	vd->en_list =3D g_new0(char *, num + 1);
>> +
>> +	num =3D 0;
>> +	g_at_result_iter_init(&iter, result);
>> +
>> +	while (g_at_result_iter_next(&iter, "+XLEMA:")) {
>> +		if (!g_at_result_iter_next_number(&iter, &index))
>> +			continue;
>> +
>> +		if (!g_at_result_iter_next_number(&iter, &total_cnt))
>> +			continue;
>> +
>> +		if (!g_at_result_iter_next_string(&iter, &number))
>> +			continue;
>> +
>> +		/* Skip the category, valid in simpresent and mcc fields */
>> +		g_at_result_iter_skip_next(&iter);
>> +		g_at_result_iter_skip_next(&iter);
>> +		g_at_result_iter_skip_next(&iter);
>
> What are you trying to achieve here?  Since you're not checking the
> result, it doesn't look like this code serves any purpose.

Agreed no pointing in having this as we are not going to make use of the
fields. Will be removed.

Regards,
Jeevaka

--===============4041521262288784909==--

