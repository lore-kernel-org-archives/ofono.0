Content-Type: multipart/mixed; boundary="===============2241146181600710566=="
MIME-Version: 1.0
From: Paccou, Nicolas <nicolas.paccou@intel.com>
Subject: RE: [PATCH v3] Add basic Telit UC864-G support:
Date: Wed, 20 Jul 2011 14:26:01 +0100
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69946ABFF9C6@irsmsx501.ger.corp.intel.com>
In-Reply-To: <alpine.DEB.2.00.1106081733590.30119@entw48>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2241146181600710566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernard,

I'm Nicolas Paccou, I'm in charge of validating the changes applied in new =
oFono release.
Unfortunately, I have not the hardware to be able to regress your patch: "A=
dd support for Telit UC864-G devices"

I wanted to know if you have tested your patch on Telit UC864-G devices ?
If yes, can you tell me if the result is ok ?
If not, do you able to test it and tell me the result please ?

Thanks,
Nicolas

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Bernhard Guillon
Sent: Wednesday, June 08, 2011 5:42 PM
To: ofono(a)ofono.org
Subject: Re: [PATCH v3] Add basic Telit UC864-G support:



On Tue, 7 Jun 2011, Marcel Holtmann wrote:

>> +	switch (status) {
>> +	case 0:
>> +		DBG("SIM not inserted");
>> +		ofono_sim_inserted_notify(data->sim, FALSE);
>> +		break;
>> +	case 1:
>> +		DBG("SIM inserted");
>> +		/* We need to sleep a bit */
>> +		g_timeout_add_seconds(1, sim_inserted_notify_with_timeout,
>> +								modem);
>> +		break;
>> +	case 2:
>> +		DBG("SIM inserted and PIN unlocked");
>> +		break;
>> +	case 3:
>> +		DBG("SIM inserted and ready");
>> +		break;
>
> Why are you not handling any of case 2 or 3. Are they not also mean that
> SIM is inserted. Or do they always are followed by case 1.
>

The states 2 and 3 never occurred it always reports only one event, which =

is 1. I added the other states because the manual describes them as =

something which should happen. Should I print an error or remove it?

>> +
>> +	DBG("%p", modem);
>> +
>> +	if (!ok) {
>> +		g_at_chat_unref(data->chat);
>> +		data->chat =3D NULL;
>> +		return;
>
> If I am not mistaken, then the set_powered(FALSE) call is missing here.
> Did you test this code path?

You are right I did not test this code path. I just tested it with if (ok) =

and the path is wrong.

I added it to the new patch.

Best regards,
Bernhard


--
Scanned by MailScanner.

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============2241146181600710566==--

