Content-Type: multipart/mixed; boundary="===============7103124561268057946=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] Interpret "" Alpha Id as empty data object
Date: Fri, 09 Jul 2010 12:32:01 -0500
Message-ID: <4C375D11.8060802@gmail.com>
In-Reply-To: <1278687128-8983-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7103124561268057946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/09/2010 09:52 AM, Yang Gu wrote:
> There needs to be a way to distinguish between no alphaid and "empty
> data object" because on some occasions they have different meanings.  In
> the Call Control envelope, no Alpha Identifier means the terminal can
> inform the user about the call being modified by SIM while empty data
> object means no hint should be given.

I applied this one, however I noticed that lots of unit tests for things
besides call control were affected.  Question to both of you: Should we
g_free & NULL empty Alpha Identifiers in commands that do not allow this
to be empty?

Regards,
-Denis

--===============7103124561268057946==--

