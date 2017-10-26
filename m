Content-Type: multipart/mixed; boundary="===============5116804785592755106=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH] qmi: remove request when it timeouts
Date: Thu, 26 Oct 2017 20:15:01 +0200
Message-ID: <503730fd-fb98-e7d5-5aaa-90b3fa2f764d@southpole.se>
In-Reply-To: <cf5ef8d7-9fd8-58ee-f297-158b764e1e64@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5116804785592755106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/26/2017 05:36 PM, Christophe Ronco wrote:
> Hi Jonas,
>
>
>
> On 10/26/2017 03:04 PM, Jonas Bonn wrote:
>> Hi Christophe,
>>
>> Just a few trivial fixups below.
>>
>> On 10/26/2017 02:44 PM, Christophe Ronco wrote:
>>> When modem does not answer or answers slowly to a discovery request,
>>> a timeout occurs.
>>> In timeout callback, request should be removed from queues to avoid
>>> treating answer if it arrives later.
>>> ---
>>>   drivers/qmimodem/qmi.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
>>> index c538cb9..65263d2 100644
>>> --- a/drivers/qmimodem/qmi.c
>>> +++ b/drivers/qmimodem/qmi.c
>>> @@ -1073,6 +1073,7 @@ struct discover_data {
>>>       qmi_discover_func_t func;
>>>       void *user_data;
>>>       qmi_destroy_func_t destroy;
>>> +    uint8_t tid;
>>
>> This should be uint16_t.
> tid field is set from transaction field in struct qmi_control_hdr. =

> transaction is a uint8_t, why do you want tid to be uint16_t?
> To avoid cast in discover_reply?

I was looking at the service_hdr where the tid is 16 bits... I take it =

back, uint8_t is fine.

/Jonas


--===============5116804785592755106==--

