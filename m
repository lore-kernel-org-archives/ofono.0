Content-Type: multipart/mixed; boundary="===============2810467921714311418=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: [PATCH v2 00/10] mmsd: error management
Date: Wed, 18 Apr 2012 15:26:13 +0200
Message-ID: <4F8EC0F5.9090405@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2810467921714311418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

On 04/13/2012 06:33 PM, S=C3=A9bastien Bianti wrote:
> Hi,
>
> This series concerns mmsd for ofono mailing list.
>
> This is essentially a rework of Ronald's patches.
>
> Was:
>> Hi,
>
>> These patches concern mmsd and are related to error handling while
>> receiving message.
>> The main idea is to try to recover error internally when possible and
>> drop messages that are not decodable.
>
>
> Ronald Tessier (1):
>    service: remove files when unable to decode received msg
>
> S=C3=A9bastien Bianti (9):
>    service: add debug prints
>    service: remove useless variable
>    service: add attempts counter variable
>    service: move destroy request into process_request
>    service: refactoring file closure
>    service: callbacks should return a boolean
>    service: refactoring error code
>    service: add requeue functionality
>    service: bearer activity needs to be checked
>
>   src/service.c |  134 ++++++++++++++++++++++++++++++++++++++------------=
-------
>   1 files changed, 90 insertions(+), 44 deletions(-)
>

Please ignore this set of patches since the first patch has to be =

modified. I send an updated version.
Regards

Ronald

--===============2810467921714311418==--

