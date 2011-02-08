Content-Type: multipart/mixed; boundary="===============6360686141454721777=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH v3 4/4] ifxmodem: move call creation to xcallstat_notify
Date: Tue, 08 Feb 2011 11:24:20 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802DEBBFF@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <4D50BEE6.1070901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6360686141454721777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> =

> So if you really insist on creating the call with a
> particular id, you might as well make that a parameter of the
> create_call function. However, do note that you still have one
> potential problem. =

> If the ATD callback returns before the call is signaled, then
> oFono synthesizes an outgoing call and picks an ID for you
> (according to the rules I outlined).  If the ID that oFono
> picked doesn't match the ID you have, you're in trouble.  So
> I'm not sure if you still want to go through all this trouble or
> not... =


Yep, agreed. Atleast with ifx I can confirm that ATD callback returns
before the call is signalled. I still want to have the call creation
done inside the xcallstat_notify so that call creation remains in
one place and also done in a place which has call id information.

>>  	/* Assume the CLIP always arrives, and we signal the call there
*/
>> DBG("cring_notify"); @@ -617,13 +636,16 @@ static void
>>  	ccwa_notify(GAtResult *result, gpointer user_data)
GAtResultIter
>>  	iter; const char *num; int num_type, validity, cls;
>> +	GSList *l;
>>  	struct ofono_call *call;
>> =

>> -	/* Some modems resend CCWA, ignore it the second time around */
>> -	if (g_slist_find_custom(vd->calls,
>> +	l =3D g_slist_find_custom(vd->calls,
> =

> Can CCWA repeat on IFX?

CCWA comes only one time in IFX.

Regards,
Jeevaka

--===============6360686141454721777==--

