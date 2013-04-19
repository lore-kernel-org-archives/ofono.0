Content-Type: multipart/mixed; boundary="===============0515174786240745784=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 1/7] doc: Add ECNR to Handsfree
Date: Fri, 19 Apr 2013 17:43:28 -0300
Message-ID: <CAKT1EBcvPQQEWwAFVD3h3445uLj0ZoJ-vCDHO_5P7S0HrV8ENw@mail.gmail.com>
In-Reply-To: <20130419201123.GA10478@x220.P-661HNU-F1>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0515174786240745784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johan:

On Fri, Apr 19, 2013 at 5:11 PM, Johan Hedberg <johan.hedberg@gmail.com> =
wrote:
> Hi Claudio,
>
> On Fri, Apr 19, 2013, Claudio Takahasi wrote:
>> This patch adds echo canceling and noise reduction property to Handsfree
>> interface, allowing the handsfree unit to enable or disable this feature
>> in the audio gateway.
>>
>> According to Bluetooth HFP 1.6 spec: By default, if the AG supports its
>> own embedded echo canceling and/or noise reduction functions, it shall
>> have them activated until the AT+NREC command is received.
>> ---
>>  doc/handsfree-api.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
>> index 0b5d421..f877db0 100644
>> --- a/doc/handsfree-api.txt
>> +++ b/doc/handsfree-api.txt
>> @@ -56,6 +56,13 @@ Properties array{string} Features [readonly]
>>                       to activate or deactivate the function from the HF=
, or
>>                       the AG could autonomously initiate it.
>>
>> +             boolean ECNR [readwrite]
>> +
>> +                     Boolean representing whether echo canceling and no=
ise
>> +                     reduction is enabled in the AG. This property may =
be
>> +                     written to activate or deactivate this feature from
>> +                     the HF unit.
>
> Why would we want to have two different acronyms, NREC and ECNR, for the
> same thing? We can't get rid of what's defined in the AT command
> specification, so why add more confusion by inventing a second acronym?
>
> Johan

I did myself the same question. I started the implementation using
NREC, but I realized later that oFono uses ECNR: HFP_AG_FEATURE_ECNR.
The HFP spec also mention "echo canceling and noise reduction".

If everybody agrees I can rename it to NREC, no problem.

Regards,
Claudio.

--===============0515174786240745784==--

