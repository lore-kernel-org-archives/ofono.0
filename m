Content-Type: multipart/mixed; boundary="===============0883640632658452618=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 4/6] stkutil.c: Send at least the data currently available
Date: Wed, 13 Apr 2011 11:54:43 +0200
Message-ID: <4DA572E3.3070808@linux.intel.com>
In-Reply-To: <4DA3D7BA.4050001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0883640632658452618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04/12/2011 06:40 AM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 04/08/2011 11:33 AM, Philippe Nunes wrote:
>> ---
>>   src/stkutil.c |    3 ++-
>>   1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/stkutil.c b/src/stkutil.c
>> index 7299fb5..ee59841 100644
>> --- a/src/stkutil.c
>> +++ b/src/stkutil.c
>> @@ -5655,7 +5655,8 @@ static gboolean build_receive_data(struct stk_tlv_=
builder *builder,
>>   	const struct stk_response_receive_data *receive_data =3D
>>   		&response->receive_data;
>>
>> -	if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS)
>> +	if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS&&
>> +			response->result.type !=3D STK_RESULT_TYPE_MISSING_INFO)
>>   		return TRUE;
>>
>>   	if (receive_data->rx_data.len) {
>
> Does this check also belong on other data object builders?
>
> Regards,
> -Denis
>

Here the purpose of this check is to allow to return the data currently =

available in the channel buffer even if the terminal response is =

"Command performed with missing information".
Indeed, this status shall be set when the requested number of bytes is =

not yet available in the Rx buffer.

Now, the general result could also be set to "command performed, with =

missing information" when the terminal received at least the minimum set =

of component parts, but did not receive all of the parts that it =

believed mandatory for the UICC to send;
But, currently, we are always returning "Error, required values are =

missing" when this case occurs.
So far, only the terminal response for the proactive command 'Receive =

data' is therefore concerned by this check.

Regards,

Philippe.

--===============0883640632658452618==--

