Content-Type: multipart/mixed; boundary="===============8113852934843736169=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH v3 13/26] gatppp: add g_at_ppp_suspend() definition
Date: Wed, 04 May 2011 11:25:55 +0200
Message-ID: <4DC11BA3.4020608@linux.intel.com>
In-Reply-To: <4DBEA2FC.4000801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8113852934843736169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,

On 02/05/2011 14:26, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 04/01/2011 03:56 AM, Guillaume Zajac wrote:
>> ---
>>   gatchat/gatppp.c |    9 +++++++++
>>   1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
>> index 9df6b8e..5f005fe 100644
>> --- a/gatchat/gatppp.c
>> +++ b/gatchat/gatppp.c
>> @@ -484,6 +484,15 @@ void g_at_ppp_shutdown(GAtPPP *ppp)
>>   	pppcp_signal_close(ppp->lcp);
>>   }
>>
>> +void g_at_ppp_suspend(GAtPPP *ppp)
>> +{
>> +	if (ppp =3D=3D NULL)
>> +		return;
>> +
>> +	ppp_net_suspend_interface(ppp->net);
>> +	g_at_hdlc_suspend(ppp->hdlc);
>> +}
>> +
> What do you think of automatically calling ppp_net_suspend_interface
> when the ppp suspend callback is triggered?  e.g. using a proxy function
> in g_at_ppp_set_suspend_function.

Good idea, thus we only need to resume GAtServer into ppp_suspend() into =

emulator.c
However, like for g_at_hdlc_suspend(), we might need to call this =

function from gsmdial to make some tests.

>>   void g_at_ppp_ref(GAtPPP *ppp)
>>   {
>>   	g_atomic_int_inc(&ppp->ref_count);
> Regards,
> -Denis
>

Kind regards,
Guillaume

--===============8113852934843736169==--

