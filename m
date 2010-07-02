Content-Type: multipart/mixed; boundary="===============6340408328688237539=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 04/23] write_file: make transaction-safe
Date: Fri, 02 Jul 2010 15:39:27 -0500
Message-ID: <4C2E4E7F.4040407@gmail.com>
In-Reply-To: <a283c18ee155df3cbd35b94a448cbfa0002c54e2.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6340408328688237539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 06/25/2010 06:15 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> write_file(), as written wasn't transaction-safe; a crash bewtween a
> file being open and the buffer being written before a safe close would
> leave the file with a set of undetermined contents.
> =

> Modified to the file is written to a temporary file name; once
> completed, it is renamed to the final name. This way, a crash in the
> middle doesn't leave half-baked files.

Patch is fine, but:

Applying: write_file: make transaction-safe
/home/denkenz/ofono-master/.git/rebase-apply/patch:13: trailing whitespace.
/*
/home/denkenz/ofono-master/.git/rebase-apply/patch:22: trailing whitespace.
 */
/home/denkenz/ofono-master/.git/rebase-apply/patch:75: trailing whitespace.
	g_free(tmp_path);		=

fatal: 3 lines add whitespace errors.

Regards,
-Denis

--===============6340408328688237539==--

