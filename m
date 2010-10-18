Content-Type: multipart/mixed; boundary="===============2202086605862905433=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 2/5] stk: Support send ss response
Date: Mon, 18 Oct 2010 16:04:02 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4733022D331@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C9FE9F0.2020509@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2202086605862905433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,



>-----Original Message-----
>From: Denis Kenzior [mailto:denkenz(a)gmail.com]
>Sent: Monday, September 27, 2010 8:49 AM
>To: ofono(a)ofono.org
>Cc: Gu, Yang
>Subject: Re: [PATCH 2/5] stk: Support send ss response
>
>Hi Yang,
>
>On 09/21/2010 05:21 AM, Yang Gu wrote:
>> ---
>>  src/stkutil.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/stkutil.c b/src/stkutil.c
>> index cdd6b4e..d35094b 100644
>> --- a/src/stkutil.c
>> +++ b/src/stkutil.c
>> @@ -5449,6 +5449,8 @@ const unsigned char *stk_pdu_from_response(const
>struct stk_response *response,
>>  					&response->select_item.item_id,
>>  					NULL);
>>  		break;
>> +	case STK_COMMAND_TYPE_SEND_SS:
>> +		break;
>
>This seems wrong, isn't the additional information field mandatory?

I couldn't understand this comment well. Additional information is a part o=
f result dataobj, so it's already included. Is there something I should han=
dle further? =



Regards,
-Yang

--===============2202086605862905433==--

