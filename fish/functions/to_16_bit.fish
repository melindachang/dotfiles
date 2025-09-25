function to_16_bit
    for f in (ls | rg flac)
        mkdir processed
        ffmpeg -i $f -sample_fmt s16 -ar 44100 processed/$f
    end
end
