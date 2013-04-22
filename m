Content-Type: multipart/mixed; boundary="===============0502492649371308508=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 1/7] doc: Add EchoCancelingNoiseReduction to Handsfree
Date: Mon, 22 Apr 2013 06:56:36 -0500
Message-ID: <51752574.7010705@gmail.com>
In-Reply-To: <CAKT1EBeQ=ttv5r6M99fzwLCCMJ4Hb5WiC6wEbCt4qmHwNgoi-g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0502492649371308508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 04/22/2013 11:46 AM, Claudio Takahasi wrote:
> Hi Denis:
>
> On Mon, Apr 22, 2013 at 6:04 AM, Denis Kenzior<denkenz@gmail.com>  wrot=
e:
>> Hi Claudio,
>>
>>
>> On 04/22/2013 07:58 AM, Claudio Takahasi wrote:
>>>
>>> This patch adds echo canceling and noise reduction property to Handsfree
>>> interface, allowing the handsfree unit to enable or disable this feature
>>> in the audio gateway.
>>>
>>> According to Bluetooth HFP 1.6 spec: By default, if the AG supports its
>>> own embedded echo canceling and/or noise reduction functions, it shall
>>> have them activated until the AT+NREC command is received.
>>> ---
>>>    doc/handsfree-api.txt | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
>>> index 0b5d421..6855d93 100644
>>> --- a/doc/handsfree-api.txt
>>> +++ b/doc/handsfree-api.txt
>>> @@ -56,6 +56,13 @@ Properties   array{string} Features [readonly]
>>>                          to activate or deactivate the function from the
>>> HF, or
>>>                          the AG could autonomously initiate it.
>>>
>>> +               boolean EchoCancelingNoiseReduction [readwrite]
>>> +
>>> +                       Boolean representing whether echo canceling and
>>> noise
>>> +                       reduction is enabled in the AG. This property m=
ay
>>> be
>>> +                       written to activate or deactivate this feature
>>> from
>>> +                       the HF unit.
>>> +
>>
>>
>> This feature can only be disabled, not enabled for a given SLC.  So sett=
ing
>> this to 'True' should return an error or do something way fancier.
>>
>> I suspect that to implement this properly we need to store the ECNR sett=
ing
>> on disk (e.g. /var/lib/ofono/<local bdaddr>/<remote bdaddr>/handsfree or
>> something) and manage it appropriately inside the core.
>
> It is true, the HFP spec defines the procedure to disable it only.
> I implemented an option to disable it because I noticed different
> behavior between the phones/modems. Anyway, I will remove it, we can
> extend the API later if necessary.

This interface is specific to HFP, so don't worry about real modems.

>
> Regarding the storage, the spec (page 53) is a little bit confusing to
> me, I understood that the AG will enable it again when the connection
> is dropped. So, we don't need to stored it.
>

In theory we could remember the previous setting and just simply send it =

automatically the next time a device is connected.  However, your =

approach will be fine for now.

Regards,
-Denis

--===============0502492649371308508==--

