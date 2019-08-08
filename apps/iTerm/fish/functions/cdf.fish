function cdf --description 'change working directory to the top-most Finder window location'
	cd (osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)');
end
