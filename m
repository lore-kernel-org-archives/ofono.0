Content-Type: multipart/mixed; boundary="===============5048152870771142562=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: [PATCH 3/3] doc: Add new D-Bus methods to service interface
Date: Tue, 22 May 2012 16:03:24 +0200
Message-ID: <4FBB9CAC.7090401@linux.intel.com>
In-Reply-To: <CAMOw1v7m-RrXE26cA0ggdT3VW3mF8XbJkuGYu8Zd2Ak64X7-wA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5048152870771142562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/22/2012 03:22 PM, Lucas De Marchi wrote:
> On Mon, May 21, 2012 at 12:59 PM, Ronald Tessier
> <ronald.tessier@linux.intel.com>  wrote:
>> ---
>>   doc/service-api.txt |   20 ++++++++++++++++++++
>>   1 files changed, 20 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/service-api.txt b/doc/service-api.txt
>> index 36e1161..02396ff 100644
>> --- a/doc/service-api.txt
>> +++ b/doc/service-api.txt
>> @@ -63,6 +63,26 @@ Methods              array{object,dict} GetMessages()
>>                                 [service].Error.PermanentContentNotAccep=
ted
>>                                 [service].Error.PermanentLackOfPrepaid
>>
>> +               void DeleteMessages(array{object})
>> +
>> +                       Delete an array of message objects that represen=
ts
>> +                       the currently stored messages to delete.
>> +
>> +                       Possible Errors: [service].Error.InvalidArguments
>> +
>> +               void DeleteConversation(string number)
>
>
> Could we mark these as [TODO], so we don't  get confused while reading
> the doc + code and realizing they don't match?
>

Sure, I re-sent a set of patches with the [TODO].
Thanks for the remark,

Ronald

--===============5048152870771142562==--

