Content-Type: multipart/mixed; boundary="===============4671028185840442210=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: [PATCHv1 5/5] doc: Update service-api.txt
Date: Fri, 27 Apr 2012 15:30:34 +0200
Message-ID: <4F9A9F7A.1090006@linux.intel.com>
In-Reply-To: <1335529214.16897.462.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4671028185840442210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 04/27/2012 02:20 PM, Marcel Holtmann wrote:
> Hi Ronald,
>
>>   doc/service-api.txt |    9 ++++++++-
>>   1 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/doc/service-api.txt b/doc/service-api.txt
>> index 46989f4..99e80be 100644
>> --- a/doc/service-api.txt
>> +++ b/doc/service-api.txt
>> @@ -24,11 +24,18 @@ Methods		array{object,dict} GetMessages()
>>   			that are part of a conversation between the service
>>   			entity and the number provided.
>>
>> +			The number parameter must only contains	significant digits
>
> actually using "must" is a wrong description.
>> +			to look for (i.e.: n last digits of the phone number), only
>> +			messages with a recipient containing the given number will
>> +			be part of the GetConversation result.
>
> And I am not sure we do wanna make some sort of assumption here anyway.
> These are not CLIP numbers where the operators don't seem to get this
> right. For SMS and MMS is seems the international numbering plan is
> used.
>
> Or do you have counter examples. If so, please post them here first.

I fully agree with you, for received MMS the international format is =

used. But for sent messages, the number is given by the user, the number =

can be international or local format, it can even contain '-' or '.'. =

For example, in my storage, received message used +33612345678 and sent =

message used the local version such as 0612345678, to get the =

conversation, we need to look for 612345678.
That's why I proposed to limit the number parameter (the one we're =

looking for in the messages) to its significant digits in =

GetConversation method.

Otherwise (if we want to use international format for number parameter) =

we have to force the user to only use international numbering plan when =

sending message, is it right ?

>
>> +
>>   			The count parameter can either be 0 for unlimited
>>   			messages in the conversation or limit the conversation
>>   			to count last messages.
>>
>> -			Possible Errors: [service].Error.InvalidArguments
>> +			Possible Errors:
>> +				[service].Error.InvalidArguments
>> +				[service].Error.TransientFailure
>
> Please don't invent your own indentation here. Keep it aligned as all
> the other documents in oFono and mmsd do.
No problem, I'll also change 'SendMessage' documentation to  indent as =

it is done in oFono ;-)

Regards,

Ronald

--===============4671028185840442210==--

