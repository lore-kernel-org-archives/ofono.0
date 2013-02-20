Content-Type: multipart/mixed; boundary="===============8696506861013143291=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 04/11] hfp_audio: Add initial manager methods
 declaration
Date: Wed, 20 Feb 2013 11:55:51 -0300
Message-ID: <CAKT1EBds2FbCAMAJof6L+O9vwEmy47_HGMnvHXfnENSq2gzS1Q@mail.gmail.com>
In-Reply-To: <51241C64.9020908@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8696506861013143291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

On Tue, Feb 19, 2013 at 9:44 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Claudio,
>
>
> On 02/19/2013 02:44 PM, Claudio Takahasi wrote:
>>
>> This patch adds the initial Handsfree Audio Manager D-Bus methods
>> declaration.
>> ---
>>   plugins/hfp_audio.c | 64
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 63 insertions(+), 1 deletion(-)
>>
>
> Actually I'd like this to move into the core (e.g. src/) directory.  It
> should look similar to manager.c.
>
> Regards,
> -Denis

Ok. I will move the Handsfree Audio Manager to src/handfree-audio.c
Another alternative is to put Audio Manager and Audio Cards inside the
existent src/handsfree.c
It is becoming a little bit confusing since there is a file
src/handsfree.c and include/handsfree.h

In the next patches we will need to add a function to create the Audio
Cards. For HF, we could hide the registration inside
ofono_handsfree_create, but this approach will not fit for AG.

Regards,
Claudio

--===============8696506861013143291==--

