Content-Type: multipart/mixed; boundary="===============5893663037844218815=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 3/3] Interpret "" Alpha Id as empty data object
Date: Sun, 11 Jul 2010 21:59:33 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731F09B094@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C375D11.8060802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5893663037844218815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Denis Kenzior
>Sent: Saturday, July 10, 2010 1:32 AM
>To: ofono(a)ofono.org
>Cc: Zaborowski, Andrew; Yang Gu
>Subject: Re: [PATCH 3/3] Interpret "" Alpha Id as empty data object
>
>On 07/09/2010 09:52 AM, Yang Gu wrote:
>> There needs to be a way to distinguish between no alphaid and "empty
>> data object" because on some occasions they have different meanings.  In
>> the Call Control envelope, no Alpha Identifier means the terminal can
>> inform the user about the call being modified by SIM while empty data
>> object means no hint should be given.
>
>I applied this one, however I noticed that lots of unit tests for things
>besides call control were affected.  Question to both of you: Should we
>g_free & NULL empty Alpha Identifiers in commands that do not allow this
>to be empty?

If we know the alpha_id in some ber-tlvs couldn't be empty, we need an extr=
a check and report the error. But the question is do we know any?
Currently I think the empty alpha_id has similar meaning for the applicatio=
n.

>
>Regards,
>-Denis
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

Regards,
-Yang

--===============5893663037844218815==--

