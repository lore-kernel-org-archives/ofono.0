Content-Type: multipart/mixed; boundary="===============0626319509508896308=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 5/6] stkutil: Complete the TLV parsing/builder to support
 BIP commands
Date: Fri, 25 Mar 2011 17:51:17 +0100
Message-ID: <4D8CC805.30205@linux.intel.com>
In-Reply-To: <4D8B55EA.90909@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0626319509508896308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/24/2011 03:32 PM, Denis Kenzior wrote:
> Hi Philippe,
>
>>>>    struct stk_network_access_name {
>>>> -    unsigned char name[127];
>>>> +    unsigned char name[100];
>>>>        unsigned char len;
>>>
>>> This part really makes no sense.  Since you parse it into a string,
>>> might as well just use that.
>>
>> All the above comments are just relevant. Thank you for having spent
>> time to point all these remarks and especially all the coding style
>> noncompliances. I will apply your comments in a new patch and separate
>> cleaning/typo modifications in another dedicated patch.
>>
>> Here, the apn string is indeed extracted from the encoded buffer.
>> As the encoded apn just can't exceeed 100 bytes as per the spec and as
>> the extracted string is lesser than 100 bytes since we are removing the
>> octet length field , I considered that the string buffer was better
>> sized with 100 bytes than 127. But perhaps, I'm over thinking here...
>>
>
> Then just remove this structure and use a static buffer for the apn/nan...
>
>>>
>>>>    };
>>>>
>>>> @@ -1250,6 +1298,21 @@ struct stk_command_launch_browser {
>>>>        char *text_passwd;
>>>>    };
>>>>
>>>> +struct stk_command_open_channel {
>>>> +    char *alpha_id;
>>>> +    struct stk_icon_id icon_id;
>>>> +    struct stk_bearer_description bearer_desc;
>>>> +    unsigned short buf_size;
>>>> +    struct stk_network_access_name network_name;
>>>
>>> E.g. char *network_name;
>>>
>
> e.g. char name[100] here.
>
>>>> +        /* The number of bytes remaining in the Rx buffer */
>>>> +        unsigned int data_left_length;
>>>
>>> So maybe rx_remaining is a better name?
>>>
>>>> +        /*
>>>> +         * The number of bytes of empty space available
>>>> +         * in the Tx buffer
>>>> +         */
>>>> +        unsigned int empty_data_length;
>>>
>>> And tx_avail here?
>>>
>>> Then you don't need the comments ;)
>>>
>>> Also, why do you use unsigned int instead of unsigned char?
>>>
>>
>> In practice, the size (rx_remaining or tx_avail) can reach 65535 as the
>> buffer size it self given by the UICC is encoded by 2 bytes. I could
>> consider indeed to use at least an unsigned short, but to be homogeneous
>> with the type of the buffer size given by data.len, I preferred to go
>> with an unsigned int.
>
> Stick with actual datatypes used on the wire.  If this is an 8 bit
> sequence with FF used to mean 255 bytes or more, then use that.  The
> logic that fills this structure will have to take care of that.
>
> Besides, you use unsigned char in stk_response_receive_data and
> stk_response_send_data, so might as well be consistent.
>
> Use of unsigned int should be limited to the length field of the TLV,
> and even then we might have to change this later for fields that are shor=
t.
>
> Regards,
> -Denis
>

Indeed the size to be returned in the Terminal response is encoded with =

one byte (reason why you can find an unsigned char in the structures =

stk_response_receive_data and stk_response_send_data).
I understand also the logic that fills the Data Length structure:
	stk_tlv_builder_append_byte(tlv, MIN(*length, 255))

but I really need to store the real number of bytes remaining/available, =

and this number can exceed 255. So, I would like to keep this data type =

or at least go for an unsigned short.



Regarding the modifications I did in the enum section/structures, you wrote:

 >Can you do me a favor and add the Section # for the enums / structs
 >you're modifying / introducing where needed.  We were supposed to be
 >doing this but somehow were not consistent enough over time.

Could you clarify with an example ?
Thanks.

Regards,

Philippe.







--===============0626319509508896308==--

