Content-Type: multipart/mixed; boundary="===============5088271933341783425=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH] Fix busylooped in ppp_disconnect for huawei modem
Date: Tue, 27 Jul 2010 12:52:29 +0800
Message-ID: <33AB447FBD802F4E932063B962385B3528AA1E6F@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C4E51D2.4050709@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5088271933341783425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

> On 07/26/2010 09:39 PM, Zhenhua Zhang wrote:
>> Huawei modem closes the modem port after PPP disconnect. So the
>> channel =

>> of gatchat is NULL in ppp_disconnect. In such case, we should not
>> resume =

>> the chat and call disconnect function when removing the context.
> =

> Please reword the last sentence, we should resume the chat, but the
> question is of timing...

It should be something like 'not resume the chat twice'. One is in
ppp_disconnect and the second is in at_gprs_context_remove.

>> Secondly, before removing the gprs context, we should reply the
>> pending =

>> DBus message to the client.
>> ---
>>  drivers/atmodem/gprs-context.c |   13 ++++++++++++-
>>  1 files changed, 12 insertions(+), 1 deletions(-)
>> =

>> diff --git a/drivers/atmodem/gprs-context.c
>> b/drivers/atmodem/gprs-context.c =

>> index fea80b0..e2f291a 100644
>> --- a/drivers/atmodem/gprs-context.c
>> +++ b/drivers/atmodem/gprs-context.c
>> @@ -88,11 +88,22 @@ static void
>>  	ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_data) =

>>  	{ struct ofono_gprs_context *gc =3D user_data; struct
>> gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc); +	GAtIO
>> *io =3D g_at_chat_get_io(gcd->chat); =

>> =

>>  	DBG("");
>> =

>>  	g_at_ppp_unref(gcd->ppp);
>>  	gcd->ppp =3D NULL;
>> +
>> +	if (g_at_io_get_channel(io) =3D=3D NULL) {
>> +		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
>> +					NULL, NULL, NULL, gcd->cb_data);
>> +		gcd->active_context =3D 0;
>> +		gcd->state =3D STATE_IDLE;
>> +		g_at_chat_resume(gcd->chat);
>> +		return;
>> +	}
>> +
> =

> Instead of doing that, can't we simply move g_at_chat_resume to the
> bottom of the function and put in a comment this might cause
> gprs_context_remove to get called?

It's better than my current way. The updated patch will send out soon. Plea=
se =

review it.

>>  	g_at_chat_resume(gcd->chat);
>> =

>>  	switch (gcd->state) {
>> @@ -257,7 +268,7 @@ static void at_gprs_context_remove(struct
>> ofono_gprs_context *gc) =

>> =

>>  	DBG("");
>> =

>> -	if (gcd->state !=3D STATE_IDLE) {
>> +	if (gcd->state !=3D STATE_IDLE && gcd->ppp) {
> =

> This along with the funny g_at_chat_resume logic is what seems to be
> causing the infinite loop.
> =

>>  		g_at_ppp_unref(gcd->ppp);
>>  		g_at_chat_resume(gcd->chat);
>>  	}
> =

> Thanks,
> -Denis



Regards,
Zhenhua

--===============5088271933341783425==--

