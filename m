Content-Type: multipart/mixed; boundary="===============6669866389577975283=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: [PATCH 2/3] doc: Describe delivered group in storage doc
Date: Thu, 07 Jun 2012 16:33:47 +0200
Message-ID: <4FD0BBCB.1060903@linux.intel.com>
In-Reply-To: <1339037001.1817.120.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6669866389577975283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 06/07/2012 04:43 AM, Marcel Holtmann wrote:
> Hi Ronald,
>
>>   doc/storage.txt |   30 ++++++++++++++++++++++++++++++
>>   1 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/storage.txt b/doc/storage.txt
>> index 8e76382..0aa6d9d 100644
>> --- a/doc/storage.txt
>> +++ b/doc/storage.txt
>> @@ -18,6 +18,7 @@ Meta file Example
>>   [info]
>>   read=3Dfalse
>>   state=3Dnotification
>> +message_id=3D0123456789ABCDEF
>
> I would just shortcut this to "id". Or is the a reason to keep
> "message_id" for this?
Let's go for "id"

>
>>   Meta file Keys/Values details
>> @@ -31,3 +32,32 @@ state: The message local state, possible values can b=
e:
>>       - "received": m-Retrieve.Conf PDU downloaded and successfully ackn=
owledged.
>>       - "draft": m-Send.Req PDU ready for sending.
>>       - "sent": m-Send.Req PDU successfully sent.
>> +
>> +message_id: this is the value provided in the M-Send.conf PDU (assigned=
 by MMSC
>> +in response to a M-Send.req message), this entry will only be created u=
pon
>> +M-Send.conf message reception if the delivery report was requested.
>> +
>> +For sent messages, a group [delivery_status] could take place in additi=
on to
>> +[info] if delivery report is requested.
>> +In this group, every recipient has a MMS Delivery status value which ca=
n be one
>> +of the following:
>> +    - "none": no report has been received yet.
>> +    - "expired": recipient did not retrieve the MMS before expiration.
>> +    - "retrieved": MMS successfully retrieved by the recipient.
>> +    - "rejected": recipient rejected the MMS.
>> +    - "deferred": recipient decided to retrieve the MMS at a later time.
>> +    - "indeterminate": cannot determine if the MMS reached its destinat=
ion.
>> +    - "forwarded": recipient forwarded the MMS without retrieving it fi=
rst.
>> +    - "unreachable": recipient is not reachable.
>> +
>> +
>> +Example of a sent_message meta file with delivery report requested
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +[info]
>> +state=3Dsent
>> +message_id=3D0123456789ABCDEF
>> +
>> +[delivery_status]
>> +21345=3Dretrieved
>> +09876=3Dnone
>
> How is this suppose to work. I am kinda failing to see what this tries
> to solve.
>

If the delivery-report is requested, a delivery_status group will be =

created in the message meta file. This group will be used to manage the =

received delivery_report sent by each recipients. This group will have =

an entry per recipient, the associated value will be set to "none" =

(which means no report has been received yet) and updated upon report =

reception. The stored "id" (provided by the MMSC in the Send.conf msg) =

must match the received "id" in the delivery.ind push msg sent by each =

recipients.

This intents to handle and store delivery reports received status. Next =

step will be to define how to let the upper layer knows about the =

delivery reporting status.

Best regards,

Ronald

--===============6669866389577975283==--

