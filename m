Content-Type: multipart/mixed; boundary="===============6308686365949586007=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 1/7] doc: Add ECNR to Handsfree
Date: Fri, 19 Apr 2013 18:17:56 -0300
Message-ID: <CAKT1EBcTAEp_e=jNCfDEc2FwBwKr=7N3fB2BqvK=pkQp1R_9_Q@mail.gmail.com>
In-Reply-To: <51716195.2040207@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6308686365949586007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis/Johan:

On Fri, Apr 19, 2013 at 12:24 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Claudio,
>
>
> On 04/19/2013 12:34 PM, Claudio Takahasi wrote:
>>
>> This patch adds echo canceling and noise reduction property to Handsfree
>> interface, allowing the handsfree unit to enable or disable this feature
>> in the audio gateway.
>>
>> According to Bluetooth HFP 1.6 spec: By default, if the AG supports its
>> own embedded echo canceling and/or noise reduction functions, it shall
>> have them activated until the AT+NREC command is received.
>> ---
>>   doc/handsfree-api.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
>> index 0b5d421..f877db0 100644
>> --- a/doc/handsfree-api.txt
>> +++ b/doc/handsfree-api.txt
>> @@ -56,6 +56,13 @@ Properties   array{string} Features [readonly]
>>                         to activate or deactivate the function from the
>> HF, or
>>                         the AG could autonomously initiate it.
>>
>> +               boolean ECNR [readwrite]
>> +
>> +                       Boolean representing whether echo canceling and
>> noise
>> +                       reduction is enabled in the AG. This property may
>> be
>> +                       written to activate or deactivate this feature
>> from
>> +                       the HF unit.
>> +
>
>
> I really prefer we used full words instead of an acronym.  You'll find we
> have no acronyms in the oFono APIs.

The feature's name doesn't help, which name do you prefer?

* EchoCancelingAndNoiseReduction
* EchoNoise

Any other suggestion?

Regards,
Claudio

--===============6308686365949586007==--

