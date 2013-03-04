Content-Type: multipart/mixed; boundary="===============0416463209174482157=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 09/10] handsfree-audio: Add function to get hfp version
Date: Mon, 04 Mar 2013 13:02:22 -0300
Message-ID: <CAKT1EBd2hUz1vAGbfX2rQC=5zuSdYn+g1W+OQ8sBE0gQjzL8Vw@mail.gmail.com>
In-Reply-To: <5131042F.7030208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0416463209174482157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

On Fri, Mar 1, 2013 at 4:40 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Claudio,
>
>
> On 02/28/2013 12:52 PM, Claudio Takahasi wrote:
>>
>> This patch adds a new function to read the local supported Handsfree
>> Profile version.
>> ---
>>   include/handsfree-audio.h | 1 +
>>   src/handsfree-audio.c     | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
>> index c5403c7..96597c2 100644
>> --- a/include/handsfree-audio.h
>> +++ b/include/handsfree-audio.h
>> @@ -34,6 +34,7 @@ struct ofono_handsfree_card
>> *ofono_handsfree_card_create(const char *remote,
>>                                                         const char
>> *local);
>>   int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
>>   void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
>> +enum hfp_version ofono_handsfree_get_version();
>>
>
> I'd like to avoid such details in the card functionality.
>
> Are our possible scenarios the following?
>
> 1. SCO defer in kernel, CVSD mSBC supported

yes.

> 2. SCO defer not in kernel, CVSD mSBC supported

not possible. Wide band speech requires defer setup to set the SCO
parameters properly.

> 3. SCO defer in kernel, CVSD supported

yes.

> 4. SCO defer not in kernel, CVSD supported

yes.

>
> If so, can we always advertise HFP 1.6, but only declare support for CVSD=
 in
> case 2?

I am not a spec (or qualification) expert, but  I will try to expose
my understanding of the docs:

For case 2, my understanding is: if HF supports *only* CVSD
(mandatory), it doesn't make sense to inform that codec negotiation is
supported. HFP 1.5 (or older) shall not indicate that it supports
codec negotiation (during service level connection negotiation) and it
should not set the wide band speech support in the service record.

One thing that I can't answer is if it is allowed to inform in the
service record that the HF supports HFP 1.6 (version), but don't set
the wide band speech feature in record.

Regards,
Claudio

--===============0416463209174482157==--

