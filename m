Content-Type: multipart/mixed; boundary="===============3750284629349032236=="
MIME-Version: 1.0
From: Jens Rehsack <jr_extern@vfnet.de>
Subject: SUPL Tests based on oFono
Date: Mon, 25 Jun 2012 15:45:13 +0200
Message-ID: <4FE86B69.9020703@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3750284629349032236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

first snapshots of the planned SUPL tests has been uploaded to
http://repo.or.cz/:
- http://repo.or.cz/w/Net-Radio-Location-SUPL-Test.git
- http://repo.or.cz/w/Net-Radio-Modem.git
- http://repo.or.cz/w/Net-Radio-oFono.git
- http://repo.or.cz/w/Net-Radio-Modem-Adapter-oFono.git

I set up my local test environment using local::lib like following:
$ mkdir -p /data/devel/vfnet && cd /data/devel/vfnet
$ for repo in Net-Radio-Modem Net-Radio-oFono \
	Net-Radio-Modem-Adapter-oFono \
	Net-Radio-Location-SUPL-Test; \
  do git clone http://repo.or.cz/w/${repo}.git ${repo}; \
      (cd ${repo} && \
        perl -Mlocal::lib=3D/data/devel/vfnet/perl5 Build.PL && \
        ./Build && ./Build test && ./Build install);
  done
# starting ofono
$ (cd Net-Radio-oFono && env PIN=3D1234 perl \
	-Mlocal::lib=3D/data/devel/vfnet/perl5
	exampes/enable-modem)
# starting mmsd
$ cd Net-Radio-Location-SUPL-Test
$ perl -Mlocal::lib=3D/data/devel/vfnet/perl5 -Mblib \
	supl-test &
$ tail -f supl-test.log

For now, the dependencies have to be installed by hand using
cpan, apt-get or pkg_add.
- http://repo.or.cz/w/Net-Radio-Location-SUPL-Test.git
  + ExtUtils::CBuilder
  + ExtUtils::ParseXS
  + Test::Differences
  * Config::Any
  * Digest::SHA
  * File::ConfigDir
  * File::Find::Rule
  * Log::Any
  * Log::Any::Adapter
  * Net::DBus
  * Net::Radio::Modem::Adapter::oFono
  * Params::Util
  * Log::Log4perl
  * Log::Any::Adapter::Log4perl
- http://repo.or.cz/w/Net-Radio-Modem.git
  (core only)
- http://repo.or.cz/w/Net-Radio-oFono.git
  * Carp::Assert
  * Hash::MoreUtils
  * List::MoreUtils
  * Log::Any
  * Log::Any::Adapter
  * Net::DBus
  * Params::Util
- http://repo.or.cz/w/Net-Radio-Modem-Adapter-oFono.git
  * Net::Radio::Modem
  * Net::Radio::oFono

Hope to read some feedback before I'm going to release.

/Jens

--===============3750284629349032236==--

